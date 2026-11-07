{
  autoStart = true;
  privateNetwork = false;

  bindMounts = {
    "/nextcloud" = {
      hostPath = "/mnt/fruit-bowl/services/nextcloud";
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
        nextcloud = {
          enable = true;
          package = pkgs.nextcloud35;
          hostName = "localhost";
          config.dbtype = "sqlite";
          home = "/nextcloud";
          https = true;

          settings = {
            trusted_domains = [
              "*.loaf.boo"
            ];
          };
        };

        tailscale = {
          enable = true;
          interfaceName = "userspace-networking";
        };
      };

      networking = {
        firewall.allowedTCPPorts = [ 80 ];
        useHostResolvConf = lib.mkForce false;
      };

      services.resolved.enable = true;
      system.stateVersion = "24.11";
    };
}
