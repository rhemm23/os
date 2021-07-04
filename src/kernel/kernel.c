#include "drivers/screen.h"
#include "mem.h"

void main() {
  isr_install();

  // Enable interrupts
  asm volatile("sti");

  clear_screen();
  print_mem_layout();
}
