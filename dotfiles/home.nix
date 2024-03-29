flimpy: { pkgs, ... }:
let
  discord-wayland = pkgs.runCommand "discord
  "
    { buildInputs = [ pkgs.makeWrapper pkgs.tree pkgs.gnused ]; } ''
    makeWrapper ${pkgs.discord}/bin/discord $out/bin/discord --set NIXOS_OZONE_WL 1
    tree ${pkgs.discord}
    mkdir $out/share
    mkdir $out/share/applications
    mkdir $out/share/icons
    cp ${pkgs.discord}/opt/Discord/discord.desktop $out/share/applications/discord.desktop
    sed -i '/\/usr\/share\/discord\/Discord/c\Exec=discord' $out/share/applications/discord.desktop
    sed -i '/Icon=discord/c\Icon=$out/share/icons/discord.png' $out/share/applications/discord.desktop
    cp ${pkgs.discord}/opt/Discord/discord.png $out/share/icons/discord.png
  '';
in
{
  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
    };
  };
  home.packages = with pkgs; [
    firefox
    (vscode-with-extensions.override {
      vscodeExtensions = with flimpy.inputs.nix-vscode-extensions.extensions.${system}.vscode-marketplace; [
        golang.go
        rust-lang.rust-analyzer
        teabyii.ayu
        serayuzgur.crates
        icrawl.discord-vscode
        pkief.material-icon-theme
        jnoortheen.nix-ide
        thenuprojectcontributors.vscode-nushell-lang
        james-yu.latex-workshop
        nvarner.typst-lsp
        haskell.haskell
        justusadam.language-haskell
        streetsidesoftware.code-spell-checker
        ms-vsliveshare.vsliveshare
        eww-yuck.yuck
        ms-vscode.cpptools
        # ms-vscode.cmake-tools
        twxs.cmake
        pest.pest-ide-tools
        wakatime.vscode-wakatime
        ndmitchell.haskell-ghcid
        guidotapia2.unicode-math-vscode
        ms-vscode.hexeditor
      ];
    })
    thunderbird
    # discord
    discord-wayland
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
    minecraft
    fragments
    wineWowPackages.stable
    neovide
    r2modman
    element-desktop
    cinny-desktop
    gnome.aisleriot
    protonmail-bridge
    newsflash
    (retroarch.override {
      cores = with libretro; [
        genesis-plus-gx
        snes9x
        beetle-psx-hw
        mame
      ];
    })

    doomseeker
    gzdoom
    zandronum
  ] ++ flimpy.inputs.git-flakes.packages."${pkgs.system}";
  programs.bash.enable = true;
  programs.direnv = {
    enable = true;
    enableBashIntegration = true; # see note on other shells below
    nix-direnv = {
      enable = true;
      package = pkgs.nix-direnv;
    };
  };

  programs.git = {
    enable = true;
    userName = "Samuel Hammersberg";
    userEmail = "samuel.hammersberg@gmail.com";
    includes = [
      { path = "~/.gitconfig.local"; }
    ];
  };

  # systemd.user.services.protonmail-bridge = {
  #   Unit = {
  #     Description = "Protonmail Bridge";
  #   };
  #   Install = {
  #     WantedBy = [ "default.target" ];
  #   };
  #   Service = {
  #     ExecStart = "${pkgs.protonmail-bridge}/bin/protonmail-bridge --noninteractive --log-level info";
  #   };
  # };

  programs.carapace.enable = true;
  programs.carapace.enableNushellIntegration = true;

  dconf.settings = {
    # "/org/gnome/settings-daemon/plugins/power" = {
    #   idle-dim = false;
    # };
    "org/gnome/desktop/interface" = {
      color-scheme = "default";
      clock-show-date = false;
    };

    "org/gnome/shell" = {
      disable-user-extensions = false;

      # `gnome-extensions list` for a list
      enabled-extensions = [
        "user-theme@gnome-shell-extensions.gcampax.github.com"
        "appindicatorsupport@rgcjonas.gmail.com"
        "dash-to-panel@jderose9.github.com"
        "gsconnect@andyholmes.github.io"
        "rounded-window-corners@yilozt"
      ];
    };
  };

  # gtk = {
  #   enable = true;
  #   theme = {
  #     name = "adw-gtk3-dark";
  #     package = pkgs.adw-gtk3;
  #   };
  # };
  # home.sessionVariables.GTK_THEME = "adw-gtk3-dark";


  xdg.configFile."nushell/config.nu".source = ./nushell/config.nu;
  xdg.configFile."Code/User/settings.json".source = ./code/settings.json;
  xdg.configFile."Code/User/keybindings.json".source = ./code/keybindings.json;
  xdg.configFile."kitty/kitty.conf".source = ./kitty/kitty.conf;
  xdg.configFile."grompt/config.toml".source = ./grompt/config.toml;
  xdg.configFile."swappy/config".source = ./swappy/config;
  xdg.configFile."alacritty" = {
    source = ./alacritty;
    recursive = true;
  };
  xdg.configFile."nvim" = {
    source = ./nvim;
    recursive = true;
  };
  xdg.configFile."hypr" = {
    source = ./hypr;
    recursive = true;
  };
  xdg.configFile."waybar" = {
    source = ./waybar;
    recursive = true;
  };
  xdg.configFile."rofi" = {
    source = ./rofi;
    recursive = true;
  };
  xdg.configFile."eww" = {
    source = ./eww;
    recursive = true;
  };


  # The state version is required and should stay at the version you
  # originally installed.
  home.stateVersion = "23.05";
}
