{ inputs }:
{ pkgs, config, ... }:
let
  pkgs-ext = import inputs.nixpkgs {
    inherit (pkgs) system;
    config.allowUnfree = true;
    overlays = [ inputs.nix-vscode-extensions.overlays.default ];
  };
  path = pkgs.lib.escapeShellArg "/home/loafey/Git/niiix/home/code";
  dotfiles =
    pkgs.runCommandLocal "nixos-mutable-file-${builtins.baseNameOf path}" { }
      "ln -s ${path} $out";
  code-pkg = (
    pkgs.vscode-with-extensions.override {
      vscode = pkgs.vscodium.overrideAttrs (old: {
        installPhase = old.installPhase + ''
          # yo
          mkdir -p "$out/lib/vscode/resources/app/out/vs/workbench/"
          mkdir -p "$out/lib/vscode/resources/app/out/media/"
          cat "${./custom.css}" >> $out/lib/vscode/resources/app/out/vs/workbench/workbench.desktop.main.css
          cat "${./logoOutline.svg}"    > $out/lib/vscode/resources/app/out/media/letterpress-dark.svg
          cat "${./logoOutline.svg}"    > $out/lib/vscode/resources/app/out/media/letterpress-hcDark.svg
          cat "${./logoOutline.svg}"    > $out/lib/vscode/resources/app/out/media/letterpress-hcLark.svg
          cat "${./logoOutline.svg}"    > $out/lib/vscode/resources/app/out/media/letterpress-light.svg
        '';
      });
      vscodeExtensions = with pkgs-ext.vscode-marketplace; [
        rust-lang.rust-analyzer
        teabyii.ayu
        pkief.material-icon-theme
        myriad-dreamin.tinymist
        jnoortheen.nix-ide
        ms-vsliveshare.vsliveshare
        qwtel.sqlite-viewer
        wakatime.vscode-wakatime
        ms-vscode.hexeditor
        ms-azuretools.vscode-docker
        ms-vscode-remote.remote-ssh
        mkhl.direnv
        llvm-vs-code-extensions.vscode-clangd
        llvm-vs-code-extensions.lldb-dap
        ms-dotnettools.csharp
        geequlim.godot-tools
        ms-dotnettools.vscode-dotnet-runtime
        ms-vscode-remote.remote-containers
        tamasfe.even-better-toml
        dbaeumer.vscode-eslint
        matthewpi.caddyfile-support
      ];
    }
  );
in
{

  home.packages = [
    (pkgs.writeShellScriptBin "code" "exec -a $0 ${code-pkg}/bin/codium $@")
    code-pkg
    pkgs.harper
  ];

  xdg.configFile."Code/User/settings.json".source = "${dotfiles}/settings.json";
  xdg.configFile."Code/User/keybindings.json".source = "${dotfiles}/keybindings.json";
  xdg.configFile."VSCodium/User/settings.json".source = "${dotfiles}/settings.json";
  xdg.configFile."VSCodium/User/keybindings.json".source = "${dotfiles}/keybindings.json";
}
