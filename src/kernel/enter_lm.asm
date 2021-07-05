[bits 32]
[global enter_lm]
enter_lm:
  ; disable pm paging
  mov eax, cr0
  and eax, 0x7fff
  mov cr0, eax

  ; clear tables
  mov edi, 0x10000
  mov cr3, edi
  xor eax, eax
  mov ecx, 4096
  rep stosd
  mov edi, cr3

  ; setup page tables
  mov dword [edi], 0x11003
  add edi, 0x1000
  mov dword [edi], 0x12003
  add edi, 0x1000
  mov dword [edi], 0x13003
  add edi, 0x1000

  mov ebx, 0x00000003
  mov ecx, 512

enter_lm_set_entry:
  mov dword [edi], ebx
  add ebx, 