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

  clamav = {
    daemon.enable = true;
    updater.enable = true;
  };

  mullvad-vpn.enable = true;
  rpcbind.enable = true;

  fail2ban.enable = true;

  zfs.autoScrub = {
    enable = true;
    interval = "*-*-1,15 02:30";
  };

  openssh = {
    enable = true;
    settings = { PasswordAuthentication = false; };
  };

  vscode-server = {
    enable = true;
    enableFHS = true;
  };

  cloudflared = {
    enable = true;
    tunnels = {
      "17bd87f9-3726-4711-bcff-4a42a9833e36" = {
        credentialsFile =
          "/home/loafey/.cloudflared/17bd87f9-3726-4711-bcff-4a42a9833e36.json";
        default = "http_status:404";
        # ingress = {
        #   "basket.loafey.se" = "ssh://localhost:22";
        # };
      };
    };
  };

  geoclue2.enable = true;
  geoclue2.geoProviderUrl = "https://api.beacondb.net/v1/geolocate";
  avahi.enable = true;
  localtimed.enable = true;

  tailscale = {
    enable = true;
    useRoutingFeatures = "both";
  };

  xserver = {
    xkb = {
      variant = "";
      layout = "se";
    };
  };

  samba = {
    enable = true;
    securityType = "user";
    openFirewall = true;
    settings = {
      global = {
        "workgroup" = "WORKGROUP";
        "server string" = "breadbox";
        "netbios name" = "breadbox";
        "security" = "user";
        # "hosts allow" = "192.168.0. 127.0.0.1 localhost";
        # "hosts deny" = "0.0.0.0/0";
        "guest account" = "nobody";
        "map to guest" = "bad user";
        "allow insecure wide links" = "yes";
      };
      "private" = {
        "path" = "/mnt/fruit-bowl/services/shared/";
        "browseable" = "yes";
        "read only" = "no";
        "follow symlinks" = "yes";
        "wide links" = "yes";
      };
    };
  };
}
