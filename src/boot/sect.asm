[org 0x7c00]

kernel_offset equ 0x1000

mov [boot_drive], dl

; setup stack
mov bp, 0x7bff
mov sp, bp

call load_kernel
call enter_pm

; includes
%include "./src/boot/gdt.asm"
%include "./src/boot/disk.asm"
%include "./src/boot/bprint.asm"
%include "./src/boot/enter_pm.asm"

[bits 16]
load_kernel:
  mov bx, kernel_offset
  mov dh, 32
  mov dl, [boot_drive]
  call disk_load
  ret

[bits 32]
begin_pm:
  call kernel_offset
  jmp $

boot_drive db 0

times 510-($-$$) db 0
dw 0xaa55
