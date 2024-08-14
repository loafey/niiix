{ userName, hardwareConfig, host, serviceSetup, config, pkgs, inputs, extra-config, ... }:

{
  imports = [
    hardwareConfig
    extra-config
    (import ./../home/flatpak.nix { inherit inputs; })
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = host;
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Stockholm";

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

  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" ]; })
  ];

  console.keyMap = "sv-latin1";

  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  users.users.${userName} = {
    isNormalUser = true;
    description = userName;
    extraGroups = [ "networkmanager" "wheel" "input" "dialout" ];
    shell = pkgs.zsh;
    packages = [ ];
  };

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.permittedInsecurePackages = [
    "electron-25.9.0"
  ];

  nix = {
    package = pkgs.nixFlakes;
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
    auto-cpufreq
    p7zip
    podman-tui
    docker-compose
    ethtool
    cloudflared
    sshfs
  ];


  programs.nix-index-database.comma.enable = true;
  programs.command-not-found.enable = false;
  programs.gamemode.enable = true;
  programs.zsh.enable = true;

  environment.sessionVariables = rec {
    EDITOR = "nvim";
  };

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

  networking.firewall = {
    enable = false;
    allowedTCPPorts = [ 1337 55555 ];
    allowedUDPPortRanges = [
      { from = 4000; to = 4007; }
      { from = 8000; to = 8010; }
    ];
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

  fileSystems."/home/loafey/BreadBox" = {
    device = "localhost:/mnt/storage/shared";
    fsType = "nfs";
    options = [
      "defaults"
      "user"
      "noauto"
      "relatime"
      "nofail"
      "rw"
      "x-systemd.automount"
      "x-systemd.mount-timeout=30"
      "_netdev"
      # "sshfs_debug"
      # "loglevel=debug"
    ];
  };

  # fileSystems."/mnt/shared" = {
  #   device = "loafey@mango-pi:/mnt/storage/shared";
  #   label = "BreadBox";
  #   fsType = "sshfs";
  #   depends = [ "/" ];
  #   options = [
  #     "nodev"
  #     "noatime"
  #     "allow_other"
  #     "IdentityFile=/root/.ssh/id_ed25519"
  #     "x-systemd.automount"
  #     "x-systemd.mount-timeout=5s"
  #     # "sshfs_debug"
  #     # "loglevel=debug"
  #   ];
  # };

  environment.etc.cloudflared = {
    source = "${pkgs.cloudflared}/bin/cloudflared";
    target = "cloudflared";
  };

  # systemd.mounts = [{
  #   description = "Shared Breadbox";
  #   what = "loafey@mango-pi:/mnt/storage/shared";
  #   where = "/mnt/shared";
  #   type = "fuse.sshfs";
  #   options = "nodev,noatime,allow_other,IdentityFile=/root/.ssh/id_ed25519,sshfs_debug,loglevel=debug";
  #   enable = true;
  # }];
  # systemd.automounts = [{
  #   description = "Shared Breadbox";
  #   where = "/mnt/shared";
  #   wantedBy = [ "multi-user.target" ];
  # }];

  # environment.etc."rclone-mnt.conf".text = ''
  #   [breadbox]
  #   type = sftp
  #   host = dev.loafey.se
  #   user = loafey
  #   key_file = /root/.ssh/id_ed25519
  # '';

  # fileSystems."/mnt/shared" = {
  #   device = "breadbox:/mnt/storage/shared";
  #   fsType = "rclone";
  #   options = [
  #     "nodev"
  #     "nofail"
  #     "allow_other"
  #     "args2env"
  #     "config=/etc/rclone-mnt.conf"
  #   ];
  # };


  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?
}

