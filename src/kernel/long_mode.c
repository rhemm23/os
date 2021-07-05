#include "long_mode.h"

void print_lm_available () {
  if (lm_available()) {
    print("LONG MODE - AVAILABLE\n");
    enter_lm();
  } else {
    print("LONG MODE - NOT AVAILABLE\n");
  }
}
