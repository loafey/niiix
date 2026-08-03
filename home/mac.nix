{ config, pkgs, ... }:

{
  home.username = "loafey";
  home.homeDirectory = "/Users/loafey";

  home.stateVersion = "26.05"; # Please read the comment before changing.

  home.packages = with pkgs; [
    lsd
    gnused
    lazygit
    alacritty
    tmux
  ];

  imports = [
    ./zsh
    ./grompt
    ./alacritty
    ./tmux
  ];

  home.file = { };

  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
