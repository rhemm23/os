init_video_mode:
  pusha

  ; call method to get video mode
  mov ah, 0x0f
  int 0x10

  ; store in memory
  mov [0x9000], al

  popa
  ret
