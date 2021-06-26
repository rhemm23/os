[org 0x7c00]
mov bp, 0x8000 ; set stack base
mov sp, bp     ; set start to base

mov bx, 0x9000
mov dh, 2      ; read 2 sectors for now

call disk_load

mov dx, [0x9000]
call print_hex
call print_nl

mov dx, [0x9000 + 512]
call print_hex

jmp $

; includes
%include "./src/disk.asm"
%include "./src/print.asm"
%include "./src/print_hex.asm"

; data
HELLO:
  db 'Hello World!', 0

times 510-($-$$) db 0
dw 0xaa55

times 256 dw 0xdada
times 256 dw 0xface
