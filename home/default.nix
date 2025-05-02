{ inputs }:
{ pkgs, config, nixosConfig, ... }: {
  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
      permittedInsecurePackages = [ "electron-33.4.11" ];
    };
  };

  imports = let
    serverSoftware = if nixosConfig.networking.hostName == "mango-basket" then
      [ (import ./server { inherit inputs; }) ]
    else [
      ./services
      ./discord
      ./gnome
      (import ./code { inherit inputs; })
      (import ./packages.nix { inherit inputs; })
    ];
  in [
    ./git
    ./alacritty
    ./bash
    ./direnv
    ./carapace
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
