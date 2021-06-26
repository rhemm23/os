bios_print:
  ; save ax
  pusha

bios_print_start:
  ; get data at bx, if 0 break
  mov al, [bx]
  cmp al, 0
  je bios_print_done

  ; tty print mode, then print
  mov ah, 0x0e
  int 0x10

  ; increment pointer, loop
  add bx, 1
  jmp bios_print_start

bios_print_done:
  ; restore ax
  popa
  ret

bios_print_line:
  ; save ax
  pusha

  ; tty print mode
  mov ah, 0x0e

  ; newline char
  mov al, 0x0a
  int 0x10

  ; carriage return char
  mov al, 0x0d
  int 0x10

  ; restore ax
  popa
  ret
