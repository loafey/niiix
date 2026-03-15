{ config, ... }: {
  autoStart = true;
  privateNetwork = true;
  hostAddress = "192.168.100.50";
  localAddress = "192.168.100.51";
  hostAddress6 = "fc00::32";
  localAddress6 = "fc00::33";

  bindMounts = { "${config.age.secrets.rss.path}".isReadOnly = true; };

  config = { config, pkgs, lib, ... }: {
    services = {
      freshrss = {
        enable = true;
        passwordFile = "/run/agenix/rss";
        baseUrl = "https://rss.loaf.boo";
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
