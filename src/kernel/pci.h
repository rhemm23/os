#ifndef PCI_H
#define PCI_H

#include "string.h"
#include "drivers/screen.h"
#include "drivers/ports.h"
#include "../types.h"

struct pci {
  u16 vendor;
  u16 device;
} __attribute__((packed));

/*
 * Read a word from a pci config register
 */
u16 pci_config_readw (u8 bus, u8 slot, u8 func, u8 offset);

void print_ethernet_devices ();

#endif
