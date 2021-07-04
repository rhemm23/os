#ifndef MEM_H
#define MEM_H

#include "drivers/screen.h"
#include "../types.h"

#define NUM_ENTRIES 0x1000
#define MEM_LAYOUT 0x1002

typedef struct mem {
  u64 base_addr;
  u64 length;
  u32 type;
  u32 ext_attr;
} __attribute__((packed)) mem_t;

void print_mem_layout ();

#endif
