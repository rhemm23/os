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

u8 pci_class (u8 bus, u8 slot, u8 func) {
  u16 class = pci_config_readw(bus, slot, func, 0xA);
  return (class & 0xFF00) >> 8;
}

u8 pci_subclass (u8 bus, u8 slot, u8 func) {
  u16 class = pci_config_readw(bus, slot, func, 0xA);
  return class & 0x00FF;
}

u16 pci_vendor (u8 bus, u8 slot, u8 func) {
  return pci_config_readw(bus, slot, func, 0);
}

u16 pci_device (u8 bus, u8 slot, u8 func) {
  return pci_config_readw(bus, slot, func, 2);
}

void print_ethernet_devices () {
  u8 bus, slot, func;
  for (bus = 0; bus < 256; bus++) {
    for (slot = 0; slot < 32; slot++) {
      for (func = 0; func < 8; func++) {
        u16 vendor = pci_vendor(bus, slot, func);
        char str[20];
        num_to_str(bus, str);
        print(str);
        print(" < -- bus\n");

        if (vendor != 0xffff) {
          u8 class_code = pci_class(bus, slot, func);
          if (class_code == 0x02) {
            u16 device = pci_device(bus, slot, func);

            num_to_str(device, str);
            print(str);
            print("\n");
            num_to_str(vendor, str);
            print(str);
            print("\n");
          }
        }
      }
    }
    if (bus == 255) {
      goto done;
    }
  }
done:
  print("done\n");
}
