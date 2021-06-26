#include "screen.h"

cursor_position_t get_cursor_position () {
  // Read upper half
  port_byte_out(REG_SCREEN_CTRL, 14);
  u16 offset = port_byte_in(REG_SCREEN_DATA) << 8;

  // Read lower half
  port_byte_out(REG_SCREEN_CTRL, 15);
  offset |= port_byte_in(REG_SCREEN_DATA);

  // Compute position
  return (cursor_position_t) {
    .row = offset / (2 * MAX_COLS),
    .col = offset % (2 * MAX_COLS)
  };
}

void set_cursor_position (cursor_position_t cursor_position) {
  u16 offset = cursor_position.row * MAX_COLS + cursor_position.col;

  // Write upper half
  port_byte_out(REG_SCREEN_CTRL, 14);
  port_byte_out(REG_SCREEN_DATA, (u8)(offset >> 8));

  // Write lower half
  port_byte_out(REG_SCREEN_CTRL, 15);
  port_byte_out(REG_SCREEN_DATA, (u8)(offset & 0xFF));
}

void print_char (char c, enum color foreground, enum color background) {
  u8 foreground_byte = (u8)foreground;
  u8 background_byte = (u8)background;

  u8 attribute_byte = foreground_byte & 0xF;
  attribute_byte |= (background_byte & 0x7) << 4;

  cursor_position_t cursor_position = get_cursor_position();
  if (cursor_position.col == MAX_COLS && cursor_position.row == MAX_ROWS) {
    int i, j;
    for (i = 1; i < MAX_ROWS; i++) {
      for (j = 0; j < MAX_COLS; j++) {
        *(u8*)(((i - 1) * MAX_COLS + j) * 2) = *(u8*)((i * MAX_COLS + j) * 2);
      }
    }
    cursor_position.row--;
  }

  // Increment cursor position by 1
  if (cursor_position.col == MAX_COLS) {
    cursor_position.row++;
    cursor_position.col = 0;
  } else {
    cursor_position.col++;
  }

  u8 *screen = (u8*)VIDEO_ADDRESS;
  u16 offset = (cursor_position.row * MAX_COLS + cursor_position.col) * 2;

  // Set char and attribute
  screen[offset] = c;
  screen[offset + 1] = attribute_byte;

  // Already updated the position, but now send it to screen
  set_cursor_position(cursor_position);
}

void print (char *str, enum color foreground, enum color background) {
  for (; *str != '\0'; str++) {
    print_char(*str, foreground, background);
  }
}

void clear_screen(enum color color) {
  int i;
  u8 *screen = (u8*)VIDEO_ADDRESS;
  int screen_size = MAX_COLS * MAX_ROWS;
  for (i = 0; i < screen_size; i++) {
    screen[i * 2] = 0x00;
    screen[i * 2 + 1] = (((u8)color) & 0x7) << 4;
  }
  set_cursor_position((cursor_position_t) {
    .row = 0,
    .col = 0
  });
}
