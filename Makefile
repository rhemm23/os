c_sources := $(shell find src/kernel/ -type f -name '*.c')
headers := $(shell find src/kernel/ -type f -name '*.h')

asm_sources := $(shell find src/kernel/ -type f -name '*.asm')

obj_names := $(basename $(notdir $(c_sources)))
obj_files := $(foreach obj,$(obj_names),bin/$(obj).o)

asm_obj_names := $(basename $(notdir $(asm_sources)))
asm_obj_files := $(foreach obj,$(asm_obj_names),bin/$(obj).o)

cc=/usr/local/i386elfgcc/bin/i386-elf-gcc
ld=/usr/local/i386elfgcc/bin/i386-elf-ld
gdb=/usr/local/i386elfgcc/bin/i386-elf-gdb

run: bin/os.bin
	qemu-system-i386 -fda $<

debug: bin/os.bin bin/kernel.elf
	qemu-system-i386 -s -fda bin/os.bin &
	$(gdb) -ex "target remote localhost:1234" -ex "symbol-file bin/kernel.elf"

build: bin/os.bin

clean:
	rm -rf bin/

$(asm_obj_files): $(asm_sources) $(headers)
	mkdir -p bin
	$(foreach asm_file,$(asm_sources),nasm $(asm_file) -f elf -o bin/$(basename $(notdir $(asm_file))).o;)

$(obj_files): $(c_sources) $(headers)
	mkdir -p bin
	$(foreach c_file,$(c_sources),$(cc) -g -ffreestanding -c $(c_file) -o bin/$(basename $(notdir $(c_file))).o;)

bin/kernel.elf: bin/kernel_entry.o $(obj_files) $(asm_obj_files)
	$(ld) -o $@ -Ttext 0x7E00 $^

bin/kernel.bin: bin/kernel_entry.o $(obj_files) $(asm_obj_files)
	$(ld) -o $@ -Ttext 0x7E00 $^ --oformat binary

bin/kernel_entry.o: src/kernel/kernel_entry.asm
	mkdir -p bin
	nasm $< -f elf -o $@

bin/sect.bin: src/boot/sect.asm
	mkdir -p bin
	nasm -f bin $< -o $@

bin/boot.bin: src/boot/boot.asm
	mkdir -p bin
	nasm -f bin $< -o $@

bin/os.bin: bin/sect.bin bin/boot.bin bin/kernel.bin
	cat $^ > $@
