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
in {
  home.packages = [
    (pkgs.vscode-with-extensions.override {
      vscode = pkgs.vscode.overrideAttrs (old: {
        installPhase = old.installPhase + ''
          # yo
          mkdir -p "$out/lib/vscode/resources/app/out/vs/workbench/"
          mkdir -p "$out/lib/vscode/resources/app/out/media/"
          cat "${
            ./custom.css
          }" >> $out/lib/vscode/resources/app/out/vs/workbench/workbench.desktop.main.css
          cat "${
            ./logoOutline.svg
          }"    > $out/lib/vscode/resources/app/out/media/letterpress-dark.svg
          cat "${
            ./logoOutline.svg
          }"    > $out/lib/vscode/resources/app/out/media/letterpress-hcDark.svg
          cat "${
            ./logoOutline.svg
          }"    > $out/lib/vscode/resources/app/out/media/letterpress-hcLark.svg
          cat "${
            ./logoOutline.svg
          }"    > $out/lib/vscode/resources/app/out/media/letterpress-light.svg
        '';
      });
      vscodeExtensions = with pkgs-ext.vscode-marketplace; [
        golang.go
        rust-lang.rust-analyzer
        teabyii.ayu
        # barboss-hack.crates-io
        icrawl.discord-vscode
        pkief.material-icon-theme
        jnoortheen.nix-ide
        thenuprojectcontributors.vscode-nushell-lang
        james-yu.latex-workshop
        myriad-dreamin.tinymist
        haskell.haskell
        justusadam.language-haskell
        streetsidesoftware.code-spell-checker
        ms-vsliveshare.vsliveshare
        eww-yuck.yuck
        kaysonwu.cpptask
        qwtel.sqlite-viewer
        # asvetliakov.vscode-neovim
        # ms-vscode.cmake-tools
        twxs.cmake
        wakatime.vscode-wakatime
        ndmitchell.haskell-ghcid
        kevin-kwong.vscode-autohide-keyboard
        kvoon.command-task
        # guidotapia2.unicode-math-vscode
        marp-team.marp-vscode
        ms-vscode.hexeditor
        ms-azuretools.vscode-docker
        rreverser.llvm
        # diku.futhark-vscode
        pgourlain.erlang
        ms-vscode-remote.remote-ssh
        mkhl.direnv
        streetsidesoftware.code-spell-checker-swedish
        dart-code.flutter
        dart-code.dart-code
        svelte.svelte-vscode

        banacorn.agda-mode
        llvm-vs-code-extensions.vscode-clangd
        ms-python.python
        benjaminjurk.gas-highlight
        llvm-vs-code-extensions.lldb-dap
        swiftlang.swift-vscode

        ms-vscode-remote.remote-containers
      ];
    })
  ];

  xdg.configFile."Code/User/settings.json".source = "${dotfiles}/settings.json";
  xdg.configFile."Code/User/keybindings.json".source =
    "${dotfiles}/keybindings.json";
}
