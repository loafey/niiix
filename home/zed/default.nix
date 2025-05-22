{ inputs, config, pkgs, lib, ... }:
let
  path = pkgs.lib.escapeShellArg "/home/loafey/Git/niiix/home/zed";
  dotfiles =
    pkgs.runCommandLocal "nixos-mutable-file-${builtins.baseNameOf path}" { }
    "ln -s ${path} $out";
in {
  programs.zed-editor = {
    extensions = [ "nix" "toml" "elixir" "make" "rust" "typst" "html" "javascript" ];
    enable = true;
  };
  xdg.configFile."zed/settings.json".source =
    lib.mkForce "${dotfiles}/settings.json";
  xdg.configFile."zed/keymap.json".source =
    lib.mkForce "${dotfiles}/keymap.json";
}
