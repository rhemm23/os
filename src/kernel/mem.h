#ifndef MEM_H
#define MEM_H

#include "drivers/screen.h"
#include "../types.h"

#define MEM_LAYOUT 0x7e00

typedef struct mem {
  u64 base_addr;
  u64 length;
  u32 type;
  u32 ext_attr;
} __attribute__((packed)) mem_t;

void print_mem_layout ();

#endif
