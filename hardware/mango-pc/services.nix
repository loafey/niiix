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

  cloudflared = {
    enable = true;
    user = "loafey";
    tunnels = {
      "302fd717-721e-4904-a482-6d9981ec5ba1" = {
        credentialsFile = "/home/loafey/.cloudflared/302fd717-721e-4904-a482-6d9981ec5ba1.json";
        default = "http_status:404";
        ingress = {
          "pc.loafey.se" = {
            service = "http://localhost:6969";
          };
        };
      };
    };
  };
}
