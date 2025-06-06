# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [
      (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usbhid" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" "v4l2loopback" ];
  boot.extraModulePackages = [ ];
  # boot.kernelPackages = pkgs.linuxPackages_latest;

  fileSystems."/" =
    {
      device = "/dev/disk/by-uuid/c9e44d3e-2eb2-42aa-af9d-66d82f89556f";
      fsType = "ext4";
    };

  fileSystems."/efi" =
    {
      device = "systemd-1";
      fsType = "autofs";
    };

  fileSystems."/boot" =
    {
      device = "/dev/disk/by-uuid/71B3-AC15";
      fsType = "vfat";
    };

  swapDevices =
    [{ device = "/dev/disk/by-uuid/3b563670-4c83-4f18-a82a-335708139f27"; }];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  networking.interfaces.enp4s0.wakeOnLan = {
    enable = true;
    policy = [ "magic" ];
  };

  systemd.services.wakeonlan = {
    description = "Reenable wake on lan every boot";
    after = [ "network.target" ];
    serviceConfig = {
      Type = "simple";
      RemainAfterExit = "true";
      ExecStart = "${pkgs.ethtool}/sbin/ethtool -s enp4s0 wol g";
    };
    wantedBy = [ "default.target" ];
  };

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
