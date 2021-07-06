#ifndef PCI_H
#define PCI_H

#include "../types.h"

u16 pci_config_readw (u8 bus, u8 slot, u8 func, u8 offset);

#endif
