{ userName }: {
  xserver.enable = true;

  displayManager.autoLogin.enable = true;
  displayManager.autoLogin.user = userName;
  printing.enable = true;

  pcscd.enable = true;

  blueman.enable = false;

  fstrim.enable = true;

  fwupd.enable = true;
  rpcbind.enable = true;
  pulseaudio.enable = false;

  openssh = {
    enable = true;
    settings = { PasswordAuthentication = false; };
  };

  pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  mullvad-vpn.enable = true;
  geoclue2.enable = true;
  avahi.enable = true;
  geoclue2.geoProviderUrl = "https://api.beacondb.net/v1/geolocate";
  localtimed.enable = true;

  xserver = {
    xkb = {
      variant = "";
      layout = "se";
    };
  };

  tailscale = {
    enable = true;
    useRoutingFeatures = "both";
    # interfaceName = "userspace-networking";
  };

  power-profiles-daemon.enable = true;
  # tlp = {
  #   enable = true;
  #   settings = {
  #     CPU_SCALING_GOVERNOR_ON_AC = "performance";
  #     CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

  #     CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
  #     CPU_ENERGY_PERF_POLICY_ON_AC = "performance";

  #     CPU_MIN_PERF_ON_AC = 0;
  #     CPU_MAX_PERF_ON_AC = 100;
  #     CPU_MIN_PERF_ON_BAT = 0;
  #     CPU_MAX_PERF_ON_BAT = 20;

  #     #Optional helps save long term battery health
  #     START_CHARGE_THRESH_BAT0 = 40; # 40 and bellow it starts to charge
  #     STOP_CHARGE_THRESH_BAT0 = 80; # 80 and above it stops chargin
  #   };
  # };
}
