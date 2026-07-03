{ pkgs, ... }:
{
  home.packages = with pkgs; [
    rust-analyzer
    rustfmt
    clippy
  ];
  programs.neovim = {
    enable = true;
    withPython3 = true;
    withRuby = true;
  };
  xdg.configFile."nvim" = {
    source = ./conf;
    recursive = true;
  };
}
