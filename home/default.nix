{ inputs }:
{ pkgs, config, nixosConfig, ... }: {
  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
    };
  };

  imports = let
    serverSoftware = if nixosConfig.networking.hostName == "mango-basket" then
      [ ./server ]
    else [
      ./services
      (import ./code { inherit inputs; })
      (import ./packages.nix { inherit inputs; })
    ];
  in [
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
  ] ++ serverSoftware;

  # The state version is required and should stay at the version you
  # originally installed.
  home.stateVersion = "23.05";
}
