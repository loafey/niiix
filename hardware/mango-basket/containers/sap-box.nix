{
  autoStart = true;
  privateNetwork = true;
  hostAddress = "192.168.100.10";
  localAddress = "192.168.100.15";
  hostAddress6 = "fc00::1";
  localAddress6 = "fc00::f";

  bindMounts = {
    "/home/sapph/Media" = {
      hostPath = "/mnt/fruit-bowl/services/shared/Jellyfin/Shared";
      isReadOnly = false;
    };
  };

  config = { config, pkgs, lib, ... }: {
    services = {
      tailscale = {
        enable = true;
        interfaceName = "userspace-networking";
      };

      openssh = {
        enable = true;
        ports = [ 22 ];
        settings = {
          PasswordAuthentication = false;
          KbdInteractiveAuthentication = false;
          PermitRootLogin = "no";
          AllowUsers = [ "sapph" ];
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
