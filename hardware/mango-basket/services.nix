{ userName }: {
  xserver.enable = true;

  printing.enable = true;

  pcscd.enable = true;

  pulseaudio.enable = false;
  fwupd.enable = true;

  pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  mullvad-vpn.enable = true;
  rpcbind.enable = true;

  openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
    };
  };

  vscode-server = {
    enable = true;
    enableFHS = true;
  };

  xserver = {
    xkb = {
      variant = "";
      layout = "se";
    };
  };
}