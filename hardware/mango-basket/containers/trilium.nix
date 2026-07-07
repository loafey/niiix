{ config, ... }: {
  autoStart = true;
  privateNetwork = true;
  hostAddress = "192.168.100.60";
  localAddress = "192.168.100.61";
  hostAddress6 = "fc00::43";
  localAddress6 = "fc00::44";

  bindMounts = {
    "/data-dir" = {
      hostPath = "/mnt/fruit-bowl/services/trilium";
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
      services = {
        tailscale = {
          enable = true;
          interfaceName = "userspace-networking";
        };

        trilium-server = {
          enable = true;
          dataDir = "/data-dir";
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
