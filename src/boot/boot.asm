[org 0x0500]

kernel_offset equ 0x7e00

pop dx
mov cl, 3
mov dh, 24
mov bx, kernel_offset

; load kernel code
call disk_load

; activate a20
call a20
jc boot_a20_failed

; load memory layout
call init_mem

; load video mode
call init_video_mode

; enter protected mode, then the kernel
call enter_pm
jmp $

%include "./src/boot/a20.asm"
%include "./src/boot/gdt.asm"
%include "./src/boot/disk.asm"
%include "./src/boot/bprint.asm"
%include "./src/boot/init_mem.asm"
%include "./src/boot/init_video_mode.asm"

boot_a20_failed:
  mov bx, a20_failed_err
  call bprint
  jmp $

[bits 16]
enter_pm:
  cli                     ; disable interrupts
  lgdt [gdt_descriptor]   ; load descriptor table

  ; set 32-bit mode in cr0
  mov eax, cr0
  or eax, 0x1
  mov cr0, eax

  jmp CODE_SEG:init_pm

[bits 32]
init_pm:
  mov ax, DATA_SEG
  mov ds, ax
  mov ss, ax
  mov es, ax
  mov fs, ax
  mov gs, ax

  mov ebp, 0x7FFFF
  mov esp, ebp

  call kernel_offset
  jmp $

a20_failed_err db "Failed to activate an available a20 gate", 0

times 512-($-$$) db 0
