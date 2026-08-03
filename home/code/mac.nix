{ pkgs, config, ... }:
let
  path = pkgs.lib.escapeShellArg "/Users/loafey/Git/niiix/home/code";
  dotfiles =
    pkgs.runCommandLocal "nixos-mutable-file-${builtins.baseNameOf path}" { }
      "ln -s ${path} $out";
in
{

  home.packages = [
    (pkgs.writeShellScriptBin "code" "exec -a $0 ${pkgs.vscodium}/bin/codium $@")
    pkgs.vscodium
  ];

  xdg.configFile."../Library/Application Support/VSCodium/User/settings.json".source = "${dotfiles}/settings.json";
  xdg.configFile."../Library/Application Support/VSCodium/User/keybindings.json".source = "${dotfiles}/keybindings.json";
}
