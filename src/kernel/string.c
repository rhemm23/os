#include "string.h"

void num_to_str (u32 num, char *str) {
  int i = 0;
  do {
    str[i++] = num % 10 + '0';
  } while ((num /= 10) > 0);
  str[i] = '\0';
  reverse(str);
}

void reverse (char *str) {
  int c, i, j;
  for (i = 0, j = strlen(str) - 1; i < j; i++, j--) {
    c = str[i];
    str[i] = str[j];
    str[j] = c;
  }
}

int strlen (char *str) {
  int i = 0;
  while (str[i] != '\0') {
    i++;
  }
  return i;
}
