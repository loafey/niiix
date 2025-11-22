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
    kdePackages.kdesu
    vlc
    clinfo
    vulkan-tools
    wayland-utils
    aha
    kdePackages.xwaylandvideobridge
    kde-rounded-corners
    kdePackages.plasma-vault
    kdePackages.kaccounts-integration
    kdePackages.kaccounts-providers
    plasmusic-toolbar
    kdePackages.dolphin-plugins
    cryfs
  ];
}
