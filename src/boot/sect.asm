[org 0x7c00]

boot_offset equ 0x0500

push dx

; set ss, es
xor ax, ax
mov ss, ax
mov es, ax

; setup stack
mov bp, 0x7bff
mov sp, bp

mov bx, boot_offset
mov dh, 1
mov cl, 2

; load remaining boot code
call disk_load

; transfer to remaining boot code
jmp 0x0000:boot_offset

; includes
%include "./src/boot/disk.asm"
%include "./src/boot/bprint.asm"

times 510-($-$$) db 0
dw 0xaa55
