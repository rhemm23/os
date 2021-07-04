#include "bios_data.h"

void print_mem_layout () {
  u8 i;
  struct bios_data *bios_data = (struct bios_data*)(BIOS_DATA_ADDR);

  for (i = 0; i < bios_data->num_e820_entries; i++) {
    char str[30];

    struct e820_entry entry = bios_data->e820_entries[i];

    print("--- ");
    num_to_str(i, str);
    print(str);
    print(" ---\n");

    num_to_str(entry.addr, str);
    print(str);
    print("\n");

    num_to_str(entry.size, str);
    print(str);
    print("\n");

    num_to_str(entry.type, str);
    print(str);
    print("\n");
  }
}
