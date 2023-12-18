{ pkgs, services, programs, environment, hyprland, ... }: {
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  programs.hyprland.enable = true;
  environment.sessionVariables.WLR_NO_HARDWARE_CURSORS = "1";
  environment.sessionVariables.NIXOS_XDG_OPEN_USE_PORTAL = pkgs.lib.mkForce "";
  security.pam.services.swaylock = { };
  programs.dconf.enable = true;
  services.gnome.evolution-data-server.enable = true;
  # optional to use google/nextcloud calendar
  services.gnome.gnome-online-accounts.enable = true;
  # optional to use google/nextcloud calendar
  services.gnome.gnome-keyring.enable = true;
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
    cava
    gnome.eog
    gnome.gnome-calendar
    vlc
    dex
    brightnessctl
    libinput-gestures
    wmctrl
  ];
}
