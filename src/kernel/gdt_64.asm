[global gdt_64]

gdt_64:
  .null: equ $ - gdt_64
  dw 0xffff
  dw 0
  db 0
  db 0
  db 1
  db 0
  .code: equ $ - gdt_64
  dw 0
  dw 0
  db 0
  db 10011010b
  db 10101111b
  db 0
  .data: equ $ - gdt_64
  dw 0
  dw 0
  db 0
  db 10010010b
  db 00000000b
  db 0
  .pointer:
  dw $ - gdt_64 - 1
  dq gdt_64
