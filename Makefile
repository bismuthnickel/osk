ASM=nasm
CC=gcc
LD=ld

SRC=src
BOOT=bootloader
KERN=kernel

BUILD=build
PART=partial

IMG_SIZE=1440k

.PHONY: all test clean

all:
	mkdir -p $(BUILD) $(BUILD)/$(PART)

	$(ASM) -f bin -o $(BUILD)/$(PART)/boot.bin $(SRC)/$(BOOT)/boot.asm

	$(CC) -e entry -ffreestanding -m32 -nostdlib -fno-pie -fno-pic -o $(BUILD)/$(PART)/kernel.o -c $(SRC)/$(KERN)/kernel.c
	$(LD) -nostdlib -m elf_i386 -T tools/linker.ld -o $(BUILD)/$(PART)/kernel.bin $(BUILD)/$(PART)/kernel.o

	cat $(BUILD)/$(PART)/boot.bin $(BUILD)/$(PART)/kernel.bin > $(BUILD)/$(PART)/OS.img
	cp $(BUILD)/$(PART)/OS.img $(BUILD)/OSK.img
	truncate -s $(IMG_SIZE) $(BUILD)/OSK.img