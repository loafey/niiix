{ userName }: {
  xserver.enable = true;

  xserver.displayManager.autoLogin.enable = true;
  xserver.displayManager.autoLogin.user = userName;
  printing.enable = true;
  auto-cpufreq.enable = true;

  pcscd.enable = true;

  blueman.enable = false;

  fstrim.enable = true;

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
