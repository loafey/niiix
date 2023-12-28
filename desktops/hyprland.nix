{ pkgs, services, programs, environment, hyprland, ... }: {
  security.polkit.enable = true;
  security.polkit.extraConfig = ''
    polkit.addRule(function(action, subject) {
      if (
        subject.isInGroup("users")
          && (
            action.id == "org.freedesktop.login1.reboot" ||
            action.id == "org.freedesktop.login1.reboot-multiple-sessions" ||
            action.id == "org.freedesktop.login1.power-off" ||
            action.id == "org.freedesktop.login1.power-off-multiple-sessions"
          )
        )
      {
        return polkit.Result.YES;
      }
    })
  '';
  systemd.user.services.polkit-gnome-authentication-agent-1 = {
    description = "polkit-gnome-authentication-agent-1";
    wantedBy = [ "graphical-session.target" ];
    wants = [ "graphical-session.target" ];
    after = [ "graphical-session.target" ];
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
      Restart = "on-failure";
      RestartSec = 1;
      TimeoutStopSec = 10;
    };
  };

  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.displayManager.gdm.wayland = true;
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
    wmctrl
    swayosd
    eww-wayland
    libnotify
    socat
    jq
    python3
    polkit_gnome
  ];
}
