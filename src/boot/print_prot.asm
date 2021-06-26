[bits 32]

; constants
VIDEO_MEM equ 0xb8000
WHITE_ON_BLACK equ 0x0f

print_prot:
  pusha
  mov edx, VIDEO_MEM

print_prot_loop:
  mov al, [ebx]
  mov ah, WHITE_ON_BLACK

  cmp al, 0
  je print_prot_done

  mov [edx], ax
  add ebx, 1
  add edx, 2

  jmp print_prot_loop

print_prot_done:
  popa
  ret
