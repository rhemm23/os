[org 0x7c00]
KERNEL_OFFSET equ 0x1000

mov [BOOT_DRIVE], dl

; setup stack
mov bp, 0x9000
mov sp, bp

; log in real mode
mov bx, REAL_MODE
call print
call print_nl

call load_kernel
call switch

; includes
%include "./src/boot/gdt.asm"
%include "./src/boot/disk.asm"
%include "./src/boot/print.asm"
%include "./src/boot/switch.asm"
%include "./src/boot/print_hex.asm"
%include "./src/boot/print_prot.asm"

[bits 16]
load_kernel:
  mov bx, LOAD_KERNEL
  call print
  call print_nl

  mov bx, KERNEL_OFFSET
  mov dh, 2
  mov dl, [BOOT_DRIVE]
  call disk_load
  ret

[bits 32]
BEGIN_PM:
  mov ebx, PROT_MODE
  call print_prot
  call KERNEL_OFFSET
  jmp $

BOOT_DRIVE db 0
REAL_MODE db "Started in 16-bit real mode", 0
PROT_MODE db "Switched to 32-bit protected mode", 0
LOAD_KERNEL db "Loading kernel from disk", 0

times 510-($-$$) db 0
dw 0xaa55

