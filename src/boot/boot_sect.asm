[org 0x7c00]
KERNEL_OFFSET equ 0x1000

mov [BOOT_DRIVE], dl

; setup stack
mov bp, 0x9000
mov sp, bp

call load_kernel
call switch

; includes
%include "./src/boot/gdt.asm"
%include "./src/boot/disk.asm"
%include "./src/boot/switch.asm"
%include "./src/boot/print_hex.asm"
%include "./src/boot/bios_print.asm"
%include "./src/boot/print_prot.asm"

[bits 16]
load_kernel:
  mov bx, KERNEL_OFFSET
  mov dh, 32
  mov dl, [BOOT_DRIVE]
  call disk_load
  ret

[bits 32]
BEGIN_PM:
  call KERNEL_OFFSET
  jmp $

BOOT_DRIVE db 0

times 510-($-$$) db 0
dw 0xaa55
