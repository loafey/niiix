{ pkgs, services, programs, environment, ... }: {
  services.xserver.enable = true;
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  services.displayManager.defaultSession = "plasma";
  services.displayManager.sddm.wayland.enable = true;
  programs.dconf.enable = true;
  programs.kdeconnect.enable = true;

  environment.systemPackages = with pkgs; [
    kdePackages.kcmutils
    kdePackages.kate
    vlc
    clinfo
    glxinfo
    vulkan-tools
    wayland-utils
    aha
    xwaylandvideobridge
  ];
}
