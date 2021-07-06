#include "pci.h"

u16 pci_config_readw (u8 bus, u8 slot, u8 func, u8 offset) {
  u32 lslot = (u32)slot;
  u32 lfunc = (u32)func;
  u32 lbus = (u32)bus;
  u16 res;

  u32 address = (u32)((lbus << 16) | (lslot << 11) | (lfunc << 8) | (offset & 0xfc) | ((u32)0x80000000));
  port_dword_out(0xcf8, address);

  return (u16)((port_dword_in(0xcfc) >> ((offset & 2) * 8)) & 0xffff);
}

u16 pci_vendor (u8 bus, u8 slot, u8 function) {
  return pci_config_readw(bus, slot, function, 0);
}

u16 pci_device (u8 bus, u8 slot, u8 function) {
  return pci_config_readw(bus, slot, function, 2);
}
