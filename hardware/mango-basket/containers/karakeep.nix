{ config, ... }:
{
  autoStart = true;
  privateNetwork = true;
  hostAddress = "192.168.100.52";
  localAddress = "192.168.100.53";
  hostAddress6 = "fc00::33";
  localAddress6 = "fc00::34";

  bindMounts = {
    "${config.age.secrets.rss.path}".isReadOnly = true;
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
        karakeep = {
          enable = true;
          extraEnvironment = { };
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
