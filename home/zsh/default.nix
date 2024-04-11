{ config, ... }:
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = import ./aliases.nix;
    initExtraFirst = (builtins.readFile ./initExtraFirst.sh);
    initExtra = (builtins.readFile ./initExtra.sh);

    history = {
      size = 10000;
      path = "${config.xdg.dataHome}/zsh/history";
    };
  };
}
