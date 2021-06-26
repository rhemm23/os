#ifndef IDT_H
#define IDT_H

#include "../types.h"

#define KERNEL_CS 0x08
#define IDT_ENTRIES 256

typedef struct {
  u16 low_offset;
  u16 segment_select;
  u8 always_zero;
  u8 flags;
  u16 high_offset;
} __attribute__((packed)) idt_gate_t;

typedef struct {
  u16 limit;
  u32 base;
} __attribute__((packed)) idt_register_t;

idt_gate_t idt[IDT_ENTRIES];
idt_register_t idt_reg;

/*
 * Sets the descriptor table
 */
void set_idt ();

/*
 * Sets the handler for a specific interrupt
 */
void set_idt_gate (u8 n, u32 handler);

#endif
