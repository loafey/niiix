{
  autoStart = true;
  privateNetwork = true;
  hostAddress = "192.168.100.10";
  localAddress = "192.168.100.16";
  hostAddress6 = "fc00::1";
  localAddress6 = "fc00::2f";

  allowedDevices = [
    {
      node = "/dev/net/tun";
      modifier = "rwm";
    }
  ];

  additionalCapabilities = [
    "CAP_NET_ADMIN"
    "CAP_NET_RAW"
  ];

  bindMounts = {
    "/run/Caddyfile" = {
      hostPath = "/mnt/fruit-bowl/services/shared/Caddy/Caddyfile";
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
        };

        caddy = {
          enable = true;
          configFile = "/run/Caddyfile";
          enableReload = true;
          package = pkgs.caddy.withPlugins {
            plugins = [ "github.com/caddy-dns/cloudflare@v0.2.4" ];
            hash = "sha256-dQvk6ezY6TQ1J7PjhCXnThF/SqVgPwBO8/RXzHCY+js=";
          };
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
