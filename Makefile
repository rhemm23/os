OUT_O_DIR = bin
SRC_DIR = src

C_SOURCES := $(shell find $(SRC_DIR)/ -type f -name '*.c')
HEADERS := $(shell find $(SRC_DIR)/ -type f -name '*.h')

ASM_SOURCES := $(shell find $(SRC_DIR)/kernel -type f -name '*.asm')

OBJ_NAMES := $(basename $(notdir $(C_SOURCES)))
OBJ_FILES := $(foreach obj,$(OBJ_NAMES),$(OUT_O_DIR)/$(obj).o)

ASM_OBJ_NAMES := $(basename $(notdir $(ASM_SOURCES)))
ASM_OBJ_FILES := $(foreach obj,$(ASM_OBJ_NAMES),$(OUT_O_DIR)/$(obj).o)

CC=/usr/local/i386elfgcc/bin/i386-elf-gcc
LD=/usr/local/i386elfgcc/bin/i386-elf-ld

run: $(OUT_O_DIR)/os_image.bin
	qemu-system-i386 -fda $<

build: $(OUT_O_DIR)/os_image.bin

clean:
	rm -rf $(OUT_O_DIR)

$(ASM_OBJ_FILES): $(ASM_SOURCES) $(HEADERS)
	mkdir -p $(OUT_O_DIR)
	$(foreach asm_file,$(ASM_SOURCES),nasm $(asm_file) -f elf -o $(OUT_O_DIR)/$(basename $(notdir $(asm_file))).o;)

$(OBJ_FILES): $(C_SOURCES) $(HEADERS)
	mkdir -p $(OUT_O_DIR)
	$(foreach c_file,$(C_SOURCES),${CC} -ffreestanding -c $(c_file) -o $(OUT_O_DIR)/$(basename $(notdir $(c_file))).o;)

$(OUT_O_DIR)/kernel.bin: $(OUT_O_DIR)/kernel_entry.o $(OBJ_FILES) $(ASM_OBJ_FILES)
	$(LD) -o $@ -Ttext 0x1000 $^ --oformat binary

$(OUT_O_DIR)/kernel_entry.o: $(SRC_DIR)/boot/kernel_entry.asm
	mkdir -p $(OUT_O_DIR)
	nasm $< -f elf -o $@

$(OUT_O_DIR)/sect.bin: $(SRC_DIR)/boot/sect.asm
	mkdir -p $(OUT_O_DIR)
	nasm -f bin $< -o $@

$(OUT_O_DIR)/os_image.bin: $(OUT_O_DIR)/sect.bin $(OUT_O_DIR)/kernel.bin
	cat $^ > $@

