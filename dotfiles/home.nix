flimpy: { pkgs, ... }: {
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
      ];
    })
    thunderbird
    discord
    nixpkgs-fmt
    stremio
    neofetch

    gnome.gnome-terminal
    gnomeExtensions.tray-icons-reloaded
    gnomeExtensions.user-themes
    adw-gtk3
    gnome3.gnome-tweaks
  ];
  programs.bash.enable = true;

  programs.git = {
    enable = true;
    userName = "Samuel Hammersberg";
    userEmail = "samuel.hammersberg@gmail.com";
    includes = [
      { path = "~/.gitconfig.local"; }
    ];
  };

  dconf.settings = {
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
      ];
    };
  };

  gtk = {
    enable = true;

    theme = {
      name = "adw-gtk3";
      package = pkgs.adw-gtk3;
    };
  };
  home.sessionVariables.GTK_THEME = "adw-gtk3";


  xdg.configFile."nushell/config.nu".source = ./nushell/config.nu;
  xdg.configFile."Code/User/settings.json".source = ./code/settings.json;
  xdg.configFile."Code/User/keybindings.json".source = ./code/keybindings.json;
  xdg.configFile."kitty/kitty.conf".source = ./kitty/kitty.conf;
  xdg.configFile."grompt/config.toml".source = ./grompt/config.toml;


  # The state version is required and should stay at the version you
  # originally installed.
  home.stateVersion = "23.05";
}
