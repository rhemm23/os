#include "../drivers/screen.h"

void main() {
  isr_install();

  __asm__ __volatile__("int $2");
  __asm__ __volatile__("int $3");
}
