{ config, pkgs, git-flakes, ... }:

let 
  grompt = (builtins.elemAt git-flakes.packages."${pkgs.system}" 1);
  grompt-prompt = (builtins.elemAt git-flakes.packages."${pkgs.system}" 3);
  macosConf   = "/Users/loafey/Library/Application Support";
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
    ./../grompt
    ./../nushell
  ];

  programs.nushell = {
    enable = true;
  };

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
    pkgs.git
    pkgs.aerospace
    # grompt
    # grompt-prompt
    pkgs.nerd-fonts.fira-code
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
    (pkgs.writeShellApplication {
      name = "grompt";
      runtimeInputs = [ ];
      text = ''
      /Users/loafey/Git/personal/grompt/target/release/grompt
      '';
    })
  ];
  fonts.fontconfig.enable = true;

  home.file."${macosConf}/Code/User/settings.json".source = ./../code/settings.json;
  home.file."${macosConf}/Code/User/keybindings.json".source = ./../code/keybindings.json;
  home.file."${macosConf}/VSCodium/User/settings.json".source = ./../code/settings.json;
  home.file."${macosConf}/VSCodium/User/keybindings.json".source = ./../code/keybindings.json;

  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
