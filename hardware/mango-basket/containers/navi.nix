{
  autoStart = true;
  privateNetwork = true;
  hostAddress = "192.168.100.10";
  localAddress = "192.168.100.11";
  hostAddress6 = "fc00::1";
  localAddress6 = "fc00::4";

  bindMounts = {
    "/media" = {
      hostPath = "/mnt/fruit-bowl/services/shared/Jellyfin/Music";
      isReadOnly = false;
    };

    "/playlists" = {
      hostPath = "/mnt/fruit-bowl/services/shared/Playlists";
      isReadOnly = false;
    };
  };

  config = { config, pkgs, lib, ... }: {
    users = {
      users.navi = {
        extraGroups = [ "wheel" "networkmanager" "media" ];
        isNormalUser = true;
        uid = 1000;
      };
      groups = { media = { gid = 999; }; };
    };

    services = {
      navidrome = {
        enable = true;
        user = "navi";
        group = "media";

        settings = {
          PlaylistsPath = "/mnt/audio/playlists";
          EnableSharing = true;
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
