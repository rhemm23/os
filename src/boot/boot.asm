[org 0x0500]

kernel_offset equ 0x7e00

pop dx
mov cl, 3
mov dh, 10
mov bx, kernel_offset

; load kernel code
call disk_load

; enter protected mode, then the kernel
call enter_pm
jmp $

%include "./src/boot/gdt.asm"
%include "./src/boot/disk.asm"
%include "./src/boot/bprint.asm"

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

times 512-($-$$) db 0
