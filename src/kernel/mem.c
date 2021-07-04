#include "string.h"
#include "mem.h"

void print_mem_layout () {
  u8 num_entries = *((u8*)MEM_LAYOUT_ADDR);
  u8 i;

  for (i = 0; i < num_entries; i++) {
    char str[30];

    print("--- ");
    num_to_str(i, str);
    print(str);
    print(" ---\n");

    mem_t mem_chunk = ((mem_t*)MEM_LAYOUT_ADDR)[i];

    num_to_str(mem_chunk.base_addr, str);
    print(str);
    print("\n");

    num_to_str(mem_chunk.length, str);
    print(str);
    print("\n");

    num_to_str(mem_chunk.type, str);
    print(str);
    print("\n");

    num_to_str(mem_chunk.ext_attr, str);
    print(str);
    print("\n");
  }
}
