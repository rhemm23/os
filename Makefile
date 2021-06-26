
run: boot_sect.bin
	qemu-system-x86_64 ./boot_sect.bin

boot_sect.bin: boot_sect.asm
	nasm -f bin boot_sect.asm -o boot_sect.bin

