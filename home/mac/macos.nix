{ config, pkgs, git-flakes, ... }:

let 
  grompt = (builtins.elemAt git-flakes.packages."${pkgs.system}" 1);
  grompt-prompt = (builtins.elemAt git-flakes.packages."${pkgs.system}" 3);
in
{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "loafey";
  home.homeDirectory = "/Users/loafey";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.05"; # Please read the comment before changing.

  imports = [
    ./../alacritty
    ./../tmux
    ./../kitty
  ];

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    pkgs.neovim
    pkgs.vscode
    pkgs.lazygit
    pkgs.btop
    pkgs.alacritty
    pkgs.kitty
    pkgs.tmux
    pkgs.alt-tab-macos
    pkgs.fzf
    # grompt
    # grompt-prompt
    (pkgs.writeShellApplication {
      name = "flg";
      runtimeInputs = [ pkgs.lazygit pkgs.fzf ];
      text = ./scripts/project-lazy-git.sh;
    })
    (pkgs.writeShellApplication {
      name = "rebuild";
      runtimeInputs = [ ];
      text = ''
      home-manager switch --flake ~/Git/niiix/home/mac/
      '';
    })

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;
    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
