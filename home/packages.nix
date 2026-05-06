{ inputs }:
{
  pkgs,
  config,
  nixosConfig,
  ...
}:
{
  home.packages =
    with pkgs;
    [
      firefox
      thunderbird
      nixpkgs-fmt
      fastfetch
      slack
      protonup-qt
      krita
      obs-studio
      kdePackages.kdenlive
      prismlauncher
      fragments
      wineWow64Packages.stable
      # r2modman
      element-desktop
      aisleriot
      protonmail-bridge
      protonmail-desktop
      chromium
      wl-clipboard
      alacritty
      prettierd
      protontricks
      zenity
      ripgrep
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
      # inputs.zen-browser.packages."${system}".default
      nixfmt
      inkscape
      fluffychat
      trayscale
      feishin
      signal-desktop
      tangram
      gcc
      revolt-desktop
      immich-cli
      # zed-editor
      openmw
      picard
      cinny-desktop
      easyeffects
      jellyfin-desktop
    ]
    ++ inputs.git-flakes.packages."${pkgs.system}";
}
