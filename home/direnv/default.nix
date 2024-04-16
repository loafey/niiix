{ pkgs, ... }:
{
  programs.direnv = {
    enable = false;
    enableBashIntegration = true; # see note on other shells below
    enableZshIntegration = true;
    nix-direnv = {
      enable = true;
      package = pkgs.nix-direnv;
    };
  };
}
