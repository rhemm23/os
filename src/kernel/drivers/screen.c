#include "screen.h"

cursor_position_t get_cursor_position () {
  // Read upper half
  port_byte_out(REG_SCREEN_CTRL, 14);
  u16 offset = port_byte_in(REG_SCREEN_DATA) << 8;

  // Read lower half
  port_byte_out(REG_SCREEN_CTRL, 15);
  offset |= port_byte_in(REG_SCREEN_DATA);

  // Compute position
  u8 row = offset / MAX_COLS;
  u8 col = offset - row * MAX_COLS;

  return (cursor_position_t) {
    .row = row,
    .col = col
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

void scroll_down () {
  int i, j;
  u8 *screen = (u8*)VIDEO_ADDRESS;
  for (i = 1; i < MAX_ROWS; i++) {
    for (j = 0; j < MAX_COLS; j++) {
      screen[((i - 1) * MAX_COLS + j) * 2] = screen[(i * MAX_COLS + j) * 2];
      screen[((i - 1) * MAX_COLS + j) * 2 + 1] = screen[(i * MAX_COLS + j) * 2 + 1];
    }
  }
  // Clear the bottom row
  for (j = 0; j < MAX_COLS; j++) {
    screen[(((MAX_ROWS - 1) * MAX_COLS) + j) * 2] = 0;
    screen[(((MAX_ROWS - 1) * MAX_COLS) + j) * 2 + 1] = 0;
  }
}

void print_char_style (char c, enum color foreground, enum color background) {
  u8 foreground_byte = (u8)foreground;
  u8 background_byte = (u8)background;

  u8 attribute_byte = foreground_byte & 0xF;
  attribute_byte |= (background_byte & 0x7) << 4;

  u8 *screen = (u8*)VIDEO_ADDRESS;
  cursor_position_t cursor_position = get_cursor_position();

  // Scroll if cursor is at bottom right
  if ((cursor_position.col == MAX_COLS - 1 && cursor_position.row == MAX_ROWS - 1) || (c == '\n' && cursor_position.row == MAX_ROWS - 1)) {
    scroll_down();
    cursor_position.row--;
  }

  // Determine where the cursor should go after the char is drawn
  if (c == '\n') {
    cursor_position.col = 0;
    cursor_position.row++;
  } else if (cursor_position.col != 0 || screen[cursor_position.row * MAX_COLS * 2] != 0) {
    if (cursor_position.col == MAX_COLS - 1) {
      cursor_position.col = 0;
      cursor_position.row++;
    } else {
      cursor_position.col++;
    }
  }

  u16 offset = (cursor_position.row * MAX_COLS + cursor_position.col) * 2;

  // Set char and attribute
  if (c != '\n') {
    screen[offset] = c;
  }
  screen[offset + 1] = attribute_byte;

  // Already updated the position, but now send it to screen
  set_cursor_position(cursor_position);
}

void print_style (char *str, enum color foreground, enum color background) {
  for (; *str != '\0'; str++) {
    print_char_style(*str, foreground, background);
  }
}

void print_char (char c) {
  print_char_style(c, WHITE, BLACK);
}

void print (char *str) {
  print_style(str, WHITE, BLACK);
}

void clear_screen_style (enum color color) {
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

void clear_screen () {
  clear_screen_style(BLACK);
}
