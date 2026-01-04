{
  autoStart = true;
  privateNetwork = true;
  hostAddress = "192.168.100.10";
  localAddress = "192.168.100.13";
  hostAddress6 = "fc00::1";
  localAddress6 = "fc00::3";

  bindMounts = { };

  config = { config, pkgs, lib, ... }: {
    services = {
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
