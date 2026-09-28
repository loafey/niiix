{ config, ... }: {
  autoStart = true;
  privateNetwork = true;
  hostAddress = "192.168.100.53";
  localAddress = "192.168.100.54";
  hostAddress6 = "fc00::35";
  localAddress6 = "fc00::36";

  bindMounts = {
    "/blog" = {
      hostPath = "/home/loafey/Git/eblog";
      isReadOnly = false;
    };
    "/mnt/fruit-bowl/services/shared/eblog" = {
      hostPath = "/mnt/fruit-bowl/services/shared/eblog";
      isReadOnly = false;
    };
  };

  config =
    {
      config,
      pkgs,
      lib,
      ...
    }:
    {
      nix.settings.experimental-features = [
        "nix-command"
        "flakes"
      ];

      users = {
        users.loafey = {
          extraGroups = [
            "wheel"
            "networkmanager"
            "parrots"
          ];
          isNormalUser = true;
          uid = 1000;
        };
      };

      systemd.services.blog = {
        enable = true;
        path = [ pkgs.nix ];
        after = [ "network.target" ];
        wantedBy = [ "default.target" ];
        serviceConfig = {
          WorkingDirectory = "/blog";
          ExecStart = "${pkgs.nix}/bin/nix develop -c cargo run --release";
          User = "loafey";
          Group = "users";
        };
      };

      services = {
        cloudflared = {
          enable = true;
          tunnels."3cadb536-5196-4df0-8b34-7d652097622a" = {
            credentialsFile = "/root/.cloudflared/3cadb536-5196-4df0-8b34-7d652097622a.json";
            default = "http_status:404";
            ingress = {
              "loafey.se" = "http://localhost:8083";
            };
          };
        };

        tailscale = {
          enable = true;
          interfaceName = "userspace-networking";
        };
      };
      networking = {
        firewall.enable = false;
        useHostResolvConf = lib.mkForce false;
      };

      services.resolved.enable = true;
      system.stateVersion = "24.11";
    };
}
