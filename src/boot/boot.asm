[org 0x7e00]

mov bx, data_msg
call bprint
jmp $

%include "./src/boot/bprint.asm"

data_msg db "here", 0