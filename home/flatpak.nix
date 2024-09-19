{ inputs }: { pkgs, ... }: {
  services.flatpak = {
    enable = false;

    remotes = [{
      name = "flathub";
      location = "https://flathub.org/repo/flathub.flatpakrepo";
    }];

    update.auto = {
      enable = true;
      onCalendar = "weekly"; # Default value
    };

    packages = [
      "com.valvesoftware.SteamLink"
    ];
  };
}
