{ userName, hardwareConfig, host, serviceSetup, config, pkgs, inputs
, extra-config, ... }: {
  imports = [
    hardwareConfig
    extra-config
    (import ./../home/flatpak.nix { inherit inputs; })
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = host;
  networking.networkmanager.enable = true;

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "sv_SE.UTF-8";
    LC_IDENTIFICATION = "sv_SE.UTF-8";
    LC_MEASUREMENT = "sv_SE.UTF-8";
    LC_MONETARY = "sv_SE.UTF-8";
    LC_NAME = "sv_SE.UTF-8";
    LC_NUMERIC = "sv_SE.UTF-8";
    LC_PAPER = "sv_SE.UTF-8";
    LC_TELEPHONE = "sv_SE.UTF-8";
    LC_TIME = "sv_SE.UTF-8";
  };

  services = serviceSetup;
  # time.timeZone = "Europe/Stockholm";

  fonts.packages = with pkgs; [ cantarell-fonts nerd-fonts.fira-code ];

  console.keyMap = "sv-latin1";

  security.rtkit.enable = true;

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  users.users.${userName} = {
    isNormalUser = true;
    description = userName;
    extraGroups = [ "networkmanager" "wheel" "input" "dialout" ];
    shell = pkgs.nushell;
    packages = [ ];
    linger = config.networking.hostName == "mango-basket";
  };

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.permittedInsecurePackages =
    [ "electron-25.9.0" "jitsi-meet-1.0.8043" ];

  nix = {
    package = pkgs.nixVersions.latest;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };
  environment.systemPackages = with pkgs; [
    neovim
    nushell
    wget
    git
    mullvad-vpn
    distrobox
    tmux
    pass
    p7zip
    podman-tui
    docker-compose
    ethtool
    cloudflared
    sshfs
    lm_sensors
    sysstat
    cifs-utils
    gnupg
  ];

  programs.nix-index-database.comma.enable = true;
  programs.command-not-found.enable = false;
  programs.gamemode.enable = true;
  programs.zsh.enable = true;

  environment.sessionVariables = rec { EDITOR = "nvim"; };

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };

  programs.noisetorch.enable = true;

  virtualisation = {
    podman = {
      enable = true;
      dockerCompat = true;
      defaultNetwork.settings.dns_enabled = true;
    };
  };

  networking.firewall = if config.networking.hostName != "mango-basket" then {
    enable = false;
    allowedTCPPorts = [ 1337 55555 ];
    allowedUDPPortRanges = [
      {
        from = 4000;
        to = 4007;
      }
      {
        from = 8000;
        to = 8010;
      }
    ];
  } else {
    enable = true;
    allowedTCPPorts = [ 22 80 82 83 444 ];
    allowedUDPPortRanges = [{
      from = 51820;
      to = 51821;
    }];
  };

  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "-d";
  };

  security.wrappers."mount.nfs" = {
    setuid = true;
    owner = "root";
    group = "root";
    source = "${pkgs.nfs-utils.out}/bin/mount.nfs";
  };

  systemd.extraConfig = "DefaultTimeoutStopSec=10s";

  # systemd.mounts = if config.networking.hostName != "mango-basket" then [{
  #   type = "nfs";
  #   mountConfig = {
  #     Options =
  #       "defaults,user,noauto,relatime,nofail,rw,x-systemd.automount,x-systemd.mount-timeout=30,x-systemd.requires=network-online.target,_netdev";
  #   };
  #   what = "localhost:/mnt/storage/shared";
  #   where = "/home/loafey/BreadBox";
  # }] else
  #   [ ];

  # systemd.automounts = if config.networking.hostName != "mango-basket" then [{
  #   wantedBy = [ "multi-user.target" ];
  #   automountConfig = { TimeoutIdleSec = "600"; };
  #   where = "/home/loafey/BreadBox";
  # }] else
  #   [ ];

  # systemd.services.chuck-bread-box =
  #   if config.networking.hostName != "mango-basket" then {
  #     enable = true;
  #     before = [ "shutdown.target" ];
  #     wantedBy = [ "halt.target" "reboot.target" "shutdown.target" ];

  #     serviceConfig = {
  #       Type = "oneshot";
  #       RemainAfterExit = "true";
  #       ExecStop = "umount -f /home/loafey/BreadBox";
  #     };
  #   } else
  #     { };

  fileSystems."BreadBox" =
    pkgs.lib.mkIf (config.networking.hostName != "mango-basket") {
      mountPoint = "/home/loafey/BreadBox";
      device = "//mango-basket/private";
      fsType = "cifs";
      options = let
        # this line prevents hanging on network split
        automount_opts =
          "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";

      in [
        "${automount_opts},credentials=/etc/nixos/smb-secrets,uid=1000,gid=100"
      ];
    };

  # /mnt/storage/shared
  environment.etc.cloudflared = {
    source = "${pkgs.cloudflared}/bin/cloudflared";
    target = "cloudflared";
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?
}
