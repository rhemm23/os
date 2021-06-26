OUT_O_DIR := ./bin

run: $(OUT_O_DIR)/boot_sect.bin
	qemu-system-x86_64 $(OUT_O_DIR)/boot_sect.bin

build: $(OUT_O_DIR)/boot_sect.bin

$(OUT_O_DIR)/boot_sect.bin: $(wildcard ./src/*.asm)
	mkdir -p $(OUT_O_DIR)
	nasm -f bin ./src/boot_sect.asm -o $(OUT_O_DIR)/boot_sect.bin

