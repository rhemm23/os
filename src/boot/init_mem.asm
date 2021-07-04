signature equ 0x534d4150

; where we will store results in memory
entry_cnt equ 0x9000
data_addr equ 0x9002

init_mem:
  pusha

  mov di, data_addr
  mov ebx, 0x0

  mov si, 0

init_mem_loop:
  mov edx, signature
  mov eax, 0xe820
  mov ecx, 24

  int 0x15
  jc init_mem_done

  ; verify signature
  cmp eax, signature
  jne init_mem_err

  add si, 1
  add di, 24

  cmp ebx, 0
  je init_mem_done

  jmp init_mem_loop

init_mem_err:
  mov bx, init_mem_err_msg
  call bprint
  jmp $

init_mem_done:
  mov [entry_cnt], si
  popa
  ret

init_mem_err_msg db "Failed to initialize memory", 0
