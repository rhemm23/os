[bits 32]
[global lm_available]
cpuid_available:
  pushfd

  ; assure flags are clear
  clc
  pop eax

  ; copy eax to ecx
  mov ecx, eax

  ; flip ID bit
  xor eax, 1 << 21

  ; copy eax to flags via stack
  push eax
  popfd

  ; copy flags back to eax
  pushfd
  pop eax

  ; restore flags from ecx
  push ecx
  popfd

  ; compare old and new, if zero then CPUID not supported
  xor eax, ecx
  jz cpuid_available_err

  ; carry should not be set if true
  clc
  ret

cpuid_available_err:
  ; carry should be set if false
  stc
  ret

lm_available:
  ; check if CPUID is available
  call cpuid_available
  jc lm_available_err

  ; test if the function to test if long mode is available
  mov eax, 0x80000000
  cpuid
  cmp eax, 0x80000001
  jb lm_available_err

  ; test if long mode is available
  mov eax, 0x80000001
  cpuid
  test edx, 1 << 29
  jz lm_available_err

  ; it is available, return true
  mov eax, 0x1
  ret

lm_available_err:
  mov eax, 0x0
  ret
