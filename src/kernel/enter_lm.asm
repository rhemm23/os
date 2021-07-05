[extern gdt_64_descriptor]

[extern gdt_64_code_seg]
[extern gdt_64_data_seg]

[bits 32]
[global enter_lm]
enter_lm:
  ; disable pm paging
  mov eax, cr0
  and eax, 0x7fff
  mov cr0, eax

  ; clear tables
  mov edi, 0x2000
  mov cr3, edi
  xor eax, eax
  mov ecx, 4096
  rep stosd
  mov edi, cr3

  ; setup page tables
  mov dword [edi], 0x3003
  add edi, 0x1000
  mov dword [edi], 0x4003
  add edi, 0x1000
  mov dword [edi], 0x5003
  add edi, 0x1000

  mov ebx, 0x00000003
  mov ecx, 512

enter_lm_set_entry:
  mov dword [edi], ebx
  add ebx, 0x1000
  add edi, 8
  loop enter_lm_set_entry

  ; enable PAE-paging
  mov eax, cr4
  or eax, 1 << 5
  mov cr4, eax

  ; set EFER MSR
  mov ecx, 0xC0000080
  rdmsr
  or eax, 1 << 8
  wrmsr

  ; reenable paging
  mov eax, cr0
  or eax, 1 << 31
  mov cr0, eax

  ; setup 64 bit gdt
  lgdt [gdt_64_descriptor]
  jmp gdt_64_code_seg:init_lm

[bits 64]
init_lm:
  cli
  mov ax, gdt_64_data_seg
  mov ds, ax
  mov es, ax
  mov fs, ax
  mov gs, ax
  mov ss, ax
  mov edi, 0xb8000
  mov rax, 0x1F201F201F201F20
  mov ecx, 500
  rep stosq
  jmp $