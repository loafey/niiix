{ userName }: {
  xserver.enable = true;

  printing.enable = true;

  pcscd.enable = true;

  fwupd.enable = true;

  pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  mullvad-vpn.enable = true;

  xserver = {
    xkb = {
      variant = "";
      layout = "se";
    };
  };
}
