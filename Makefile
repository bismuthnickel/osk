SRC_DIR=src
BUILD_DIR=build
TOOLS_DIR=tools

ASM=nasm
CC=gcc

.PHONY: all bootloader kernel main_image always clean

all: clean always bootloader kernel main_image

main_image: $(BUILD_DIR)/OS.img

$(BUILD_DIR)/OS.img: $(BUILD_DIR)/bootloader.bin $(BUILD_DIR)/kernel.bin
	cat $^ > $@
	truncate -s 1440k $@

bootloader: $(BUILD_DIR)/bootloader.bin

$(BUILD_DIR)/bootloader.bin: $(SRC_DIR)/bootloader/boot.asm
	$(ASM) $< -f bin -o $@

kernel: $(BUILD_DIR)/kernel.bin

$(BUILD_DIR)/kernel.bin:
	$(ASM) -f elf32 -o $(BUILD_DIR)/kernel_entry.o $(SRC_DIR)/kernel/entry.asm
	$(CXX) -e main -ffreestanding -m32 -nostdlib -no-pie -o $(BUILD_DIR)/kernel.o $(wildcard $(SRC_DIR)/kernel/*.cpp)
	ld -nostdlib -no-pie -m elf_i386 -Map=$(BUILD_DIR)/stage2.map -T $(TOOLS_DIR)/kernel.ld -o $(BUILD_DIR)/kernel.bin $(BUILD_DIR)/kernel_entry.o $(BUILD_DIR)/kernel.o

always:
	mkdir -p $(BUILD_DIR)

clean:
	rm -rf $(BUILD_DIR)