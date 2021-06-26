[bits 16]
switch:
  cli                   ; disable interrupts
  lgdt [gdt_descriptor]  ; load descriptor table

  ; set 32-bit mode in cr0
  mov eax, cr0
  or eax, 0x1
  mov cr0, eax

  jmp CODE_SEG:init

[bits 32]
init:
  mov ax, DATA_SEG
  mov ds, ax
  mov ss, ax
  mov es, ax
  mov fs, ax
  mov gs, ax

  mov ebp, 0x90000
  mov esp, ebp

  call BEGIN_PM
