{ inputs }: { pkgs, ... }:
{
  home.packages = [
    (pkgs.vscode-with-extensions.override {
      vscode = pkgs.vscode.overrideAttrs (old: {
        installPhase = old.installPhase + ''
          # yo
          mkdir -p "$out/lib/vscode/resources/app/out/vs/workbench/"
          cat "${./custom.css}" >> $out/lib/vscode/resources/app/out/vs/workbench/workbench.desktop.main.css
        '';
      });
      vscodeExtensions = with inputs.nix-vscode-extensions.extensions.${pkgs.system}.vscode-marketplace; [
        golang.go
        rust-lang.rust-analyzer
        teabyii.ayu
        fill-labs.dependi
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
        jbenden.c-cpp-flylint
        vscode-org-mode.org-mode
        ms-python.python
      ];
    })
  ];

  xdg.configFile."Code/User/settings.json".source = ./settings.json;
  xdg.configFile."Code/User/keybindings.json".source = ./keybindings.json;
}
