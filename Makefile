OUT_O_DIR := ./bin
SRC_DIR := ./src

run: $(OUT_O_DIR)/os_image.bin
	qemu-system-i386 -fda $<

build: $(OUT_O_DIR)/os_image.bin

clean:
	rm -rf $(OUT_O_DIR)

$(OUT_O_DIR)/kernel.bin: $(OUT_O_DIR)/kernel_entry.o $(OUT_O_DIR)/kernel.o
	i386-elf-ld -o $@ -Ttext 0x1000 $^ --oformat binary

$(OUT_O_DIR)/kernel_entry.o: $(SRC_DIR)/boot/kernel_entry.asm
	nasm $< -f elf -o $@

$(OUT_O_DIR)/kernel.o: $(SRC_DIR)/kernel/kernel.c
	i386-elf-gcc -ffreestanding -c $< -o $@

$(OUT_O_DIR)/boot_sect.bin: $(SRC_DIR)/boot/boot_sect.asm
	nasm -f bin $< -o $(OUT_O_DIR)/boot_sect.bin

$(OUT_O_DIR)/os_image.bin: $(OUT_O_DIR)/boot_sect.bin $(OUT_O_DIR)/kernel.bin
	cat $^ > $@

