#include "idt.h"

void set_idt_gate (u8 n, u32 handler) {
  idt[n].low_offset = handler & 0xFFFF;
  idt[n].segment_select = KERNEL_CS;
  idt[n].always_zero = 0;
  idt[n].flags = 0x8E;
  idt[n].high_offset = (handler >> 16) & 0xFFFF;
}

void set_idt () {
  idt_reg.base = (u32)&idt;
  idt_reg.limit = IDT_ENTRIES * sizeof(idt_gate_t) - 1;

  __asm__ __volatile__("lidtl (%0)" : : "r" (&idt_reg));
}
