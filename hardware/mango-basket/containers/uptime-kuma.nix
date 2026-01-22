{
  autoStart = true;
  privateNetwork = false;

  bindMounts = { };

  config = { config, pkgs, lib, ... }: {
    services.uptime-kuma = {
      enable = true;
      settings = { UPTIME_KUMA_HOST = "0.0.0.0"; };
    };

    networking = {
      firewall.allowedTCPPorts = [ 3001 ];
      useHostResolvConf = lib.mkForce false;
    };

    services.resolved.enable = true;
    system.stateVersion = "24.11";
  };
}
