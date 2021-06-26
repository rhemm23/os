; prints the data in dx
print_hex:
  pusha

  mov cx, 0 ; index

hex_loop:
  cmp cx, 4         ; loop 4 times
  je end
  
  mov ax, dx        ; use ax
  and ax, 0x000f    ; mask to get last
  add al, 0x30      ; add '0'
  cmp al, 0x39      ; check if <= 9
  jle prepare_char  ; if so, ready, else get it to letter
  add al, 7         ; difference of 7 to get to letters

prepare_char:
  mov bx, HEX_OUT + 5 ; base + length
  sub bx, cx          ; subtract index
  mov [bx], al        ; copy char to string
  ror dx, 4           ; rotate to get next hex val

  add cx, 1
  jmp hex_loop

end:
  mov bx, HEX_OUT
  call print

  popa
  ret

HEX_OUT:
  db '0x0000', 0
