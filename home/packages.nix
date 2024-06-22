{ inputs }: { pkgs, ... }: {
  home.packages = with pkgs; [
    firefox
    thunderbird
    nixpkgs-fmt
    neofetch
    slack
    protonup-qt
    youtube-music
    krita
    lutris
    cartridges
    obs-studio
    kdePackages.kdenlive
    prismlauncher
    fragments
    wineWowPackages.stable
    neovide
    r2modman
    element-desktop
    cinny-desktop
    gnome.aisleriot
    protonmail-bridge
    newsflash
    protonmail-desktop
    chromium
    alacritty
    lsd
    floorp
    protontricks
  ] ++ inputs.git-flakes.packages."${pkgs.system}";
}
