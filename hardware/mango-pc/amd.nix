{
  config,
  lib,
  pkgs,
  ...
}:
{

  # Enable OpenGL
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      libglvnd
      libva-vdpau-driver
      libvdpau-va-gl
      vulkan-loader
      vulkan-validation-layers
      vulkan-extension-layer
      mesa
      vulkan-tools
    ];
  };

  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;

  boot.initrd.kernelModules = [ "amdgpu" ];
  boot.blacklistedKernelModules = [ ];
  boot.kernelParams = [ ];

  # Load nvidia driver for Xorg and Wayland
  services.xserver.videoDrivers = [ "amdgpu" ];
}
