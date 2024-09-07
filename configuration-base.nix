# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).

{ config, pkgs, ... }:

{

  #imports = [ ./module-thermald.nix ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  # Boot kernel parameters:
  boot.kernelParams = [
    # Mitigate screen flickering, see:
    # https://wiki.archlinux.org/title/intel_graphics#Screen_flickering
    # https://github.com/linux-surface/linux-surface/issues/862
    "i915.enable_psr=0"
  ];
  # Add the kernel modules such that we have a working keyboard for the 
  # LUKS full disk encryption.
  # https://github.com/linux-surface/linux-surface/wiki/Disk-Encryption
  boot.initrd.kernelModules = [
    "surface_aggregator"
    "surface_aggregator_registry"
    "surface_aggregator_hub"
    "surface_hid_core"
    "surface_hid"
    "pinctrl_tigerlake"
    "intel_lpss"
    "intel_lpss_pci"
    "8250_dw"
  ];

  #microsoft-surface.surface-control.enable = true;
  microsoft-surface.kernelVersion = "6.10";

  # Disable the problematic suspend kernel module, it makes waking up
  # impossible after closing the cover.
  boot.blacklistedKernelModules = [ "surface_gpe" ];

}

