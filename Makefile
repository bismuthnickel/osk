CC=gcc
LD=ld

qemu := qemu-system-x86_64
qemu_flags:=-m 2G -display sdl -name OSKr -machine q35 -usb -device usb-mouse -rtc base=localtime

INCLUDES=-Iostd

all:
	$(CC) $(INCLUDES) -nostdlib -ffreestanding -s -c boot/main.c -o BOOTX64.EFI
	./tools/make_disk -i OSK.iso -ae /EFI/BOOT/ BOOTX64.EFI
	rm -rf BOOTX64.EFI
test:
	$(qemu) -drive format=raw,unit=0,file=OSK.iso -bios tools/bios64.bin $(qemu_flags)