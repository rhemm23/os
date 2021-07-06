#ifndef BIOS_DATA_H
#define BIOS_DATA_H

#include "drivers/screen.h"
#include "../types.h"
#include "string.h"

#define MAX_E820_ENTRIES 128
#define BIOS_DATA_ADDR 0x9000

struct e820_entry {
  u64 addr;
  u64 size;
  u32 type;
  u32 attr;
} __attribute__((packed));

struct bios_data {
  u8 video_mode;
  u16 num_e820_entries;
  struct e820_entry e820_entries[MAX_E820_ENTRIES];
} __attribute__((packed));

void print_mem_layout ();

#endif
