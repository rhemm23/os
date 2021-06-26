#pragma once

#include "ports.h"
#include "color.h"
#include "../types.h"

#define VIDEO_ADDRESS 0xb8000
#define MAX_ROWS 25
#define MAX_COLS 80

#define REG_SCREEN_CTRL 0x3D4
#define REG_SCREEN_DATA 0x3D5

typedef struct cursor_position {
  u8 row;
  u8 col;
} cursor_position_t;

void clear_screen(enum color color);

void print_char (char c, enum color foreground, enum color background);

void print (char *str, enum color foreground, enum color background);
