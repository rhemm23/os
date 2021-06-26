[org 0x7c00]

mov bx, HELLO
call print

call print_nl

jmp $

; includes
%include "./src/print.asm"

; data
HELLO:
  db 'Hello World!', 0

times 510-($-$$) db 0
dw 0xaa55

