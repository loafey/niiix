{ userName }: {
  xserver.enable = true;
  #xserver.displayManager.sddm.enable = true;
  #xserver.desktopManager.plasma5.enable = true;

  xserver.displayManager.autoLogin.enable = true;
  xserver.displayManager.autoLogin.user = userName;
  printing.enable = true;

  fwupd.enable = true;

  pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  mullvad-vpn.enable = true;

  xserver = {
    layout = "se";
    xkbVariant = "";
  };
}
