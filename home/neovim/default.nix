{ ... }:
{
  programs.neovim.enable = true;
  xdg.configFile."nvim" = {
    source = ./conf;
    recursive = true;
  };
}
