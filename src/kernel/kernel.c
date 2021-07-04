#include "../drivers/screen.h"

void main() {
  isr_install();

  // Enable interrupts
  asm volatile("sti");

  clear_screen();
  print("Hello\n");
}
