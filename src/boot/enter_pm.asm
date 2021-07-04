[bits 16]
enter_pm:
  cli                   ; disable interrupts
  lgdt [gdt_descriptor]  ; load descriptor table

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

  mov ebp, 0x90000
  mov esp, ebp

  call begin_pm
