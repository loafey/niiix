{ pkgs, ... }: {
    nixpkgs = {
    config = {
        allowUnfree = true;
        allowUnfreePredicate = (_: true);
    };
    };
    home.packages = with pkgs; [ 
    firefox
    #vscode
    (vscode-with-extensions.override {
        vscodeExtensions = with inputs.nix-vscode-extensions.extensions.${system}; [
        vscode-marketplace.golang.go
        vscode-marketplace.rust-lang.rust-analyzer
        ];
    })
    thunderbird
    discord
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

    xdg.configFile."nushell/config.nu".source = ./dotfiles/config.nu;

    # The state version is required and should stay at the version you
    # originally installed.
    home.stateVersion = "23.05";
};