{ inputs }: { pkgs, ... }: {
  services.flatpak = {
    enable = true;

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
