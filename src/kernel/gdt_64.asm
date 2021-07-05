[global gdt_64_descriptor]

[global gdt_64_code_seg]
[global gdt_64_data_seg]

gdt_64:

gdt_64_null:
  dw 0xffff
  dw 0
  db 0
  db 0
  db 1
  db 0

gdt_64_code:
  dw 0
  dw 0
  db 0
  db 10011010b
  db 10101111b
  db 0

gdt_64_data:
  dw 0
  dw 0
  db 0
  db 10010010b
  db 00000000b
  db 0

gdt_64_end:

gdt_64_descriptor:
  dw gdt_64_end - gdt_64 - 1
  dq gdt_64

gdt_64_code_seg equ gdt_64_code - gdt_64
gdt_64_data_seg equ gdt_64_data - gdt_64
