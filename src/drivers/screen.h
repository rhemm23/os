#pragma once

#include "ports.h"
#include "color.h"
#include "../types.h"

#define VIDEO_ADDRESS 0xb8000
#define MAX_ROWS (u8)25
#define MAX_COLS (u8)80

#define REG_SCREEN_CTRL 0x3D4
#define REG_SCREEN_DATA 0x3D5

typedef struct cursor_position {
  u8 row;
  u8 col;
} cursor_position_t;

/*
 * Clears all text and sets the cursor to the top left corner
 */
void clear_screen ();

/*
 * Clears all text, sets the background to the passed color, and sets the cursor to the top left corner
 */
void clear_screen_style (enum color color);

/*
 * Writes a char to the screen with color
 */
void print_char_style (char c, enum color foreground, enum color background);

/*
 * Writes a string to the screen with color
 */
void print_style (char *str, enum color foreground, enum color background);

/*
 * Writes a char to the screen
 */
void print_char (char c);

/*
 * Writes a string to the screen
 */
void print (char *str);
