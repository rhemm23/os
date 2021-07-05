a20:
  pusha

  ; interrupt for A20 gate-support
  mov ax, 0x2403
  int 0x15

  ; not supported
  jb a20_ns

  cmp ah, 0
  jnz a20_ns

  ; A20 gate-status
  mov ax, 0x2402
  int 0x15
  
  ; failed to get status
  jb a20_failed

  cmp ah, 0
  jnz a20_failed

  ; check already activated
  cmp al, 1
  jz a20_activated

  ; A20 gate-activate
  mov ax, 0x2401
  int 0x15

  ; failed to activate gate
  jb a20_failed

  cmp ah, 0
  jnz a20_failed

a20_ns:

a20_activated:
  popa
  clc
  ret

a20_failed:
  popa
  stc
  ret
