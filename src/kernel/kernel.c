#include "../drivers/keyboard.h"

void main() {
  isr_install();

  // Enable interrupts
  asm volatile("sti");

  init_keyboard();
}
