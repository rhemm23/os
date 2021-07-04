#ifndef TYPES_H
#define TYPES_H

/*
 * Byte
 */
typedef unsigned char u8;

/*
 * Word
 */
typedef unsigned short u16;

/*
 * Double word
 */
typedef unsigned long int u32;

/*
 * Quad word
 */
typedef unsigned long long int u64;

/*
 * Registers received when a call is made to a c function from assembly
 */
typedef struct registers {
   u32 ds;
   u32 edi, esi, ebp, esp, ebx, edx, ecx, eax;
   u32 int_no, err_code;
   u32 eip, cs, eflags, useresp, ss;
} registers_t;

#endif
