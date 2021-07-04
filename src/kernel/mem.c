#include "mem.h"

void print_mem_layout () {
  u16 num_entries = *((u16*)MEM_LAYOUT);
  print_char(num_entries + '0');
}
