#include "drivers/screen.h"
#include "bios_data.h"
#include "long_mode.h"

void main() {
  isr_install();

  // Enable interrupts
  asm volatile("sti");

  clear_screen();
  print("still works\n");
}
