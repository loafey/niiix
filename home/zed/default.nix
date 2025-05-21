{ inputs, config, pkgs, ... }:
let
  path = pkgs.lib.escapeShellArg "/home/loafey/Git/niiix/home/zed";
  dotfiles =
    pkgs.runCommandLocal "nixos-mutable-file-${builtins.baseNameOf path}" { }
    "ln -s ${path} $out";
in {
  xdg.configFile."zed/settings.json".source = "${dotfiles}/settings.json";
  xdg.configFile."zed/keymap.json".source = "${dotfiles}/keymap.json";
}
