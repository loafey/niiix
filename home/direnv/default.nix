{ pkgs, ... }:
{
  programs.direnv = {
    enable = true;
    enableBashIntegration = true; # see note on other shells below
    enableZshIntegration = true;
    nix-direnv = {
      enable = true;
      package = pkgs.nix-direnv;
    };
  };
}
