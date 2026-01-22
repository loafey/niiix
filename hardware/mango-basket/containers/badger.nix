{
  autoStart = false;
  privateNetwork = true;
  hostAddress = "192.168.100.10";
  localAddress = "192.168.100.13";
  hostAddress6 = "fc00::1";
  localAddress6 = "fc00::3";

  bindMounts = { };

  config = { config, pkgs, lib, ... }: {
    services.mullvad-vpn.enable = true;
    environment.systemPackages = with pkgs; [ neovim ];

    networking = {
      useHostResolvConf = lib.mkForce false;
      wireguard.enable = true; # yo
      firewall = {
        enable = false;
        checkReversePath = "loose";
      };
      nat = {
        enable = true;
        internalInterfaces = [ "ve-+" ];
        externalInterface = "eno1";
        enableIPv6 = false;
      };
    };

    systemd.services."mullvad-daemon".postStart = ''
      while ! ${pkgs.mullvad}/bin/mullvad status >/dev/null; do sleep 1; done

      ${pkgs.mullvad}/bin/mullvad lan set allow
      ${pkgs.mullvad}/bin/mullvad lockdown-mode set on
      ${pkgs.mullvad}/bin/mullvad auto-connect set on

      # disconnect/reconnect is dirty hack to fix mullvad-daemon not reconnecting after a suspend
      ${pkgs.mullvad}/bin/mullvad disconnect
      sleep 0.1
      ${pkgs.mullvad}/bin/mullvad connect
    '';

    containers.tailscale = {
      autoStart = true;
      privateNetwork = true;
      hostAddress = "192.168.100.10";
      localAddress = "192.168.100.14";
      hostAddress6 = "fc00::1";
      localAddress6 = "fc00::4";

      bindMounts = { };

      config = { config, pkgs, lib, ... }: {
        services = {
          tailscale = {
            enable = true;
            interfaceName = "userspace-networking";
            useRoutingFeatures = "client";
            # extraDaemonFlags = [
            #   "--tun=userspace-networking"
            #   "--socks5-server=localhost:1055"
            #   "--outbound-http-proxy-listen=localhost:1055"
            # ];
          };
        };
        # systemd.services.tailscaled.serviceConfig.Environment =
        #   [ "TS_DEBUG_FIREWALL_MODE=nftables" ];
        # networking.nftables.enable = true;
        networking = {
          useHostResolvConf = lib.mkForce false;
          firewall.enable = false;
          #   firewall = {
          #     enable = false;
          #     trustedInterfaces = [ "tailscale0" ];
          #     checkReversePath = "loose";
          #     allowedUDPPorts = [ config.services.tailscale.port ];
          #   };
        };

        services.resolved.enable = true;
        system.stateVersion = "24.11";
      };
    };

    services.resolved.enable = true;
    system.stateVersion = "24.11";
  };
}
