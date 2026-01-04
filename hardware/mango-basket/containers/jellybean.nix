{
  autoStart = true;
  privateNetwork = true;
  hostAddress = "192.168.100.10";
  localAddress = "192.168.100.11";
  hostAddress6 = "fc00::1";
  localAddress6 = "fc00::2";

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
}
