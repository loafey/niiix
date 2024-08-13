{ inputs }: { pkgs, config, ... }:
{
  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
    };
  };

  imports = [
    ./discord
    ./git
    ./alacritty
    ./bash
    ./direnv
    ./carapace
    ./gnome
    ./nushell
    ./kitty
    ./grompt
    ./neovim
    ./zsh
    ./tmux
    ./services
    (import ./code { inherit inputs; })
    (import ./packages.nix { inherit inputs; })
  ];

  # The state version is required and should stay at the version you
  # originally installed.
  home.stateVersion = "23.05";
}
