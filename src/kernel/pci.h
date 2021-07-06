#ifndef PCI_H
#define PCI_H

#include "drivers/ports.h"
#include "../types.h"

/*
 * Read a word from a pci config register
 */
u16 pci_config_readw (u8 bus, u8 slot, u8 func, u8 offset);

/*
 * Vendor of a specific pci device at a bus and slot
 */
u16 pci_vendor (u8 bus, u8 slot, u8 function);

#endif
