magic_num equ 0x534d4150

init_mem:
  pusha

  mov di, 0x8000
  mov ebx, 0x0

  mov edx, magic_num
  mov si, 0

init_mem_loop:
  mov eax, 0xe820
  mov ecx, 24

  int 0x15
  jc init_mem_done

  add si, 1
  add di, 24

  cmp ebx, 0
  je init_mem_done

  jmp init_mem_loop

init_mem_done:

  mov [0x7FFD], si

  popa
  ret
