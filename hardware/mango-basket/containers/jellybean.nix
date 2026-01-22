{
  autoStart = true;
  privateNetwork = true;
  hostAddress = "192.168.100.10";
  localAddress = "192.168.100.11";
  hostAddress6 = "fc00::1";
  localAddress6 = "fc00::4";

  bindMounts = {
    "/media" = {
      hostPath = "/mnt/fruit-bowl/services/shared/Jellyfin";
      isReadOnly = false;
    };

    "/config" = {
      hostPath = "/mnt/fruit-bowl/services/jellyfin/config";
      isReadOnly = false;
    };

    "/cache" = {
      hostPath = "/mnt/fruit-bowl/services/jellyfin/cache";
      isReadOnly = false;
    };
  };

  config = { config, pkgs, lib, ... }: {
    services = {
      jellyfin = { enable = true; };
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
