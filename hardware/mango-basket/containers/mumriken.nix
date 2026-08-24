{
  autoStart = true;
  privateNetwork = true;
  hostAddress = "192.168.100.10";
  localAddress = "192.168.100.15";
  hostAddress6 = "fc00::1";
  localAddress6 = "fc00::f";

  bindMounts = {
    "/home/snusmumriken/Media" = {
      hostPath = "/mnt/fruit-bowl/services/shared/Jellyfin/Shared";
      isReadOnly = false;
    };
  };

  config = { config, pkgs, lib, ... }: {
    users = {
      users.snusmumriken = {
        extraGroups = [
          "wheel"
          "networkmanager"
        ];
        isNormalUser = true;
        uid = 1000;
      };
    };

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
          AllowUsers = [ "snusmumriken" ];
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