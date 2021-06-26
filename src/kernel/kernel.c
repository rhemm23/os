#include "../drivers/screen.h"

void main() {
  clear_screen(BLACK);
  int i;
  for (i = 0; i < 80; i++) 
  print("Hello world!\nH", WHITE, BLACK);
}
