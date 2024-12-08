SRC_DIR=src
BUILD_DIR=build

ASM=nasm

.PHONY: all bootloader main_image always clean

all: always bootloader main_image

main_image: $(BUILD_DIR)/OS.img

$(BUILD_DIR)/OS.img: $(BUILD_DIR)/bootloader.bin $(BUILD_DIR)/kernel.bin
	cat $^ > $@
	truncate -s 1440k $@

bootloader: $(BUILD_DIR)/bootloader.bin

$(BUILD_DIR)/bootloader.bin: $(SRC_DIR)/bootloader/boot.asm
	$(ASM) $< -f bin -o $@

kernel: $(BUILD_DIR)/kernel.bin

$(BUILD_DIR)/kernel.bin: $(SRC_DIR)/kernel/main.asm
	$(ASM) $< -f bin -o $@

always:
	mkdir -p $(BUILD_DIR)

clean:
	rm -rf $(BUILD_DIR)