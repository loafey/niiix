{ userName }: {
  xserver.enable = true;

  displayManager.autoLogin.enable = true;
  displayManager.autoLogin.user = userName;
  printing.enable = true;
  auto-cpufreq.enable = false;

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
    xkb = {
      variant = "";
      layout = "se";
    };
  };
}
