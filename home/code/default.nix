{ inputs }: { pkgs, ... }:
{
  home.packages = with pkgs; [
    (vscode-with-extensions.override {
      vscodeExtensions = with inputs.nix-vscode-extensions.extensions.${system}.vscode-marketplace; [
        golang.go
        rust-lang.rust-analyzer
        teabyii.ayu
        serayuzgur.crates
        icrawl.discord-vscode
        pkief.material-icon-theme
        jnoortheen.nix-ide
        thenuprojectcontributors.vscode-nushell-lang
        james-yu.latex-workshop
        nvarner.typst-lsp
        haskell.haskell
        justusadam.language-haskell
        streetsidesoftware.code-spell-checker
        ms-vsliveshare.vsliveshare
        eww-yuck.yuck
        ms-vscode.cpptools
        # ms-vscode.cmake-tools
        twxs.cmake
        wakatime.vscode-wakatime
        ndmitchell.haskell-ghcid
        # guidotapia2.unicode-math-vscode
        marp-team.marp-vscode
        ms-vscode.hexeditor
        ms-azuretools.vscode-docker
        rreverser.llvm
        diku.futhark-vscode
      ];
    })
  ];

  xdg.configFile."Code/User/settings.json".source = ./settings.json;
  xdg.configFile."Code/User/keybindings.json".source = ./keybindings.json;
}
