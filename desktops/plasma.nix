{ pkgs, services, programs, environment, ... }: {
  services.xserver.enable = true;
  services.xserver.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  services.xserver.displayManager.defaultSession = "plasma";
  services.xserver.displayManager.sddm.wayland.enable = true;
  programs.dconf.enable = true;

  environment.systemPackages = with pkgs; [
    # xorg.libXcursor
    kdePackages.kcmutils
    kdePackages.kate
    clinfo
    glxinfo
    vulkan-tools
    wayland-utils
    aha
    xwaylandvideobridge
  ];
}
