#include "keyboard.h"

static void keyboard_callback (registers_t registers) {
  u8 scancode = port_byte_in(0x60);
}

void init_keyboard () {
  register_interrupt_handler(IRQ1, keyboard_callback);
}
