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
    ripgrep
    fragments
    wineWowPackages.stable
    neovide
    r2modman
    element-desktop
    gnome.aisleriot
    protonmail-bridge
    newsflash
    protonmail-desktop
    chromium
    wl-clipboard
    alacritty
    prettierd
    lsd
    floorp
    protontricks
    zenity
    ripgrep
    lazygit
    libreoffice-qt
    hunspell
    hunspellDicts.uk_UA
    hunspellDicts.th_TH
    bitwarden-desktop
    waypipe
    mpv
    iozone
  ] ++ inputs.git-flakes.packages."${pkgs.system}";
}
