{ inputs }:
{ pkgs, config, nixosConfig, ... }: {
  home.packages = with pkgs;
    [
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
      # r2modman
      element-desktop
      aisleriot
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
      monero-gui
      monero-cli
      xmrig-mo
      p2pool
      bruno
      zsh-history-substring-search
      obsidian
      fish
      inputs.zen-browser.packages."${system}".default
      nixfmt-classic
      lm_sensors
    ] ++ inputs.git-flakes.packages."${pkgs.system}";
}
