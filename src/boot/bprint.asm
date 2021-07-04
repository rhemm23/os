bprint:
  pusha

bprint_loop:
  mov al, [bx]
  mov ah, 0x0e

  cmp al, 0
  je bprint_done

  int 0x10
  add bx, 1

  jmp bprint_loop

bprint_done:
  popa
  ret
