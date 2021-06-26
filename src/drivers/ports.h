#pragma once

#include "../types.h"

/*
 * Reads a byte from a port
 */
u8 port_byte_in (u16 port);

/*
 * Reads a word from a port
 */
u16 port_word_in (u16 port);

/*
 * Sends a byte to a port
 */
void port_byte_out (u16 port, u8 data);

/*
 * Sends a word to a port
 */
void port_word_out (u16 port, u16 data);
