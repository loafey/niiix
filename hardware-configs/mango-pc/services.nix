{ userName }: {
  xserver.enable = true;

  printing.enable = true;

  fwupd.enable = false;

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
