{ pkgs, ... }: {
  hardware.firmware = [ pkgs.linux-firmware ];
  hardware.graphics.enable = true;
  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usb_storage" "sd_mod" "rtsx_pci_sdmmc" ];
  boot.kernelModules = [ "kvm-intel" "kvm-amd" ];
  fileSystems."/" = { device = "/dev/nvme0n1p2"; fsType = "ext4"; };
  fileSystems."/boot" = { device = "/dev/nvme0n1p1"; fsType = "vfat"; options = [ "fmask=0022" "dmask=0022" ]; };
  swapDevices = [ { device = "/dev/nvme0n1p3"; } ];
}
