/*
 * Reads a byte from a port
 */
unsigned char port_byte_in (unsigned short port);

/*
 * Reads a word from a port
 */
unsigned char port_word_in (unsigned short port);

/*
 * Sends a byte to a port
 */
void port_byte_out (unsigned short port, unsigned char data);

/*
 * Sends a word to a port
 */
void port_word_out (unsigned short port, unsigned short data);
