KERNEL_SRC = src/kernel
ISO_DIR = iso
BUILD_DIR = build

CC = i686-elf-gcc
AS = nasm
CFLAGS = -ffreestanding -O2 -Wall -Wextra
LDFLAGS = -T linker.ld -nostdlib

all: $(BUILD_DIR)/kernel.bin iso/boot/kernel.bin
	@echo "Build complete!"

$(BUILD_DIR)/kernel.o: $(KERNEL_SRC)/kernel.c
	$(CC) $(CFLAGS) -c $< -o $@

$(BUILD_DIR)/boot.o: $(KERNEL_SRC)/boot.S
	$(CC) $(CFLAGS) -c $< -o $@

$(BUILD_DIR)/kernel.bin: $(BUILD_DIR)/boot.o $(BUILD_DIR)/kernel.o
	$(CC) -T linker.ld -nostdlib -o $@ $^

iso/boot/kernel.bin: $(BUILD_DIR)/kernel.bin
	mkdir -p $(ISO_DIR)/boot
	cp $< $@

run: all
	grub-mkrescue -o $(BUILD_DIR)/kwindow.iso iso
	qemu-system-i386 -cdrom $(BUILD_DIR)/kwindow.iso

clean:
	rm -rf $(BUILD_DIR) iso/boot/kernel.bin
