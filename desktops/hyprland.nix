{ pkgs, services, programs, environment, hyprland, ... }: {
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  programs.hyprland.enable = true;
  environment.sessionVariables.WLR_NO_HARDWARE_CURSORS = "1";
  security.pam.services.swaylock = { };
  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };
  environment.systemPackages = with pkgs; [
    kitty
    alacritty
    gnome.nautilus
    pavucontrol
    pulseaudioFull
    rofi-wayland
    grim
    slurp
    swappy
    waybar
    qt5ct
    wl-clipboard
    hyprpaper
    swaylock
    hyprpicker
    mission-center
    swaynotificationcenter
  ];
}
