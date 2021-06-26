[org 0x7c00]
mov ah, 0x0e

mov al, [my_data]
int 0x10

jmp $

my_data:
  db "X"

times 510-($-$$) db 0
dw 0xaa55

