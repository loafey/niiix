{ pkgs, services, programs, environment, ... }: {
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  #services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  environment.gnome.excludePackages = (with pkgs; [
    gnome-photos
    gnome-tour
  ]) ++ (with pkgs.gnome; [
    cheese # webcam tool
    gnome-music
    gedit # text editor
    epiphany # web browser
    geary # email reader
    gnome-characters
    tali # poker game
    iagno # go game
    hitori # sudoku game
    atomix # puzzle game
    yelp # Help view
    gnome-contacts
    gnome-initial-setup
  ]);
  programs.dconf.enable = true;
  environment.variables = {
    "QT_STYLE_OVERRIDE" = "breeze";
  };
  environment.systemPackages = with pkgs; [
    gnomeExtensions.gsconnect
    kitty
    gnomeExtensions.tray-icons-reloaded
    gnomeExtensions.user-themes
    adw-gtk3
    gnome3.gnome-tweaks
    wl-clipboard
    nautilus-open-any-terminal
    amberol
    newsflash
  ];
}
