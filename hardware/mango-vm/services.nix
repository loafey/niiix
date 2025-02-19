{
  xserver.enable = true;
  xserver.displayManager.gdm.enable = true;
  xserver.desktopManager.gnome.enable = true;

  xserver.displayManager.autoLogin.enable = true;
  xserver.displayManager.autoLogin.user = userName;
  printing.enable = true;

  pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  localtimed.enable = true;
  geoclue2.enable = true;

  xserver = {
    xkb = {
      variant = "";
      layout = "se";
    };
  };
}
