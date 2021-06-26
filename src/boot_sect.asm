[org 0x7c00]
mov bp, 0x9000 ; set stack base
mov sp, bp     ; set start to base

; say we're in real mode
mov bx, REAL_MODE
call print

; switch to 32-bit
call switch
jmp $

; includes
%include "./src/gdt.asm"
%include "./src/disk.asm"
%include "./src/print.asm"
%include "./src/switch.asm"
%include "./src/print_hex.asm"
%include "./src/32bit_print.asm"

[bits 32]
BEGIN_PM:
  mov ebx, PROT_MODE
  call print_prot
  jmp $

REAL_MODE db "Started in 16-bit real mode", 0
PROT_MODE db "Switched to 32-bit protected mode", 0

times 510-($-$$) db 0
dw 0xaa55
