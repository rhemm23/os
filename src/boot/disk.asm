; load 'dh' sectors into es:bx
disk_load:
  pusha
  push dx

  mov ah, 0x02      ; read method for 0x13 interrupt
  mov al, dh        ; number of sectors to read

  mov cl, 0x02      ; sector start, 0x01 is our boot sector
  mov ch, 0x00      ; cylinder number

  mov dh, 0x00      ; head number

  int 0x13          ; BIOS interrupt
  jc disk_load_err  ; error if carry bit

  pop dx
  
  cmp al, dh
  jne disk_load_err ; read wrong number of sectors

  popa
  ret

disk_load_err:
  jmp $
