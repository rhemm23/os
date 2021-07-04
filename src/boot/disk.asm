; load 'dh' sectors into es:bx
disk_load:
  pusha

  mov [num_sectors], dh

  mov ah, 0x02      ; read method for 0x13 interrupt
  mov al, dh        ; number of sectors to read

  mov ch, 0x00      ; cylinder number
  mov dh, 0x00      ; head number

  int 0x13          ; BIOS interrupt
  jc disk_load_err  ; error if carry bit
  
  cmp al, [num_sectors]
  jne disk_load_err ; read wrong number of sectors

  popa
  ret

disk_load_err:
  mov bx, disk_err
  call bprint
  jmp $

num_sectors db 0
disk_err db "Failed to read disk", 0
