{
  description = "Other flakes :^)";

  inputs = {
    grompt.url = "github:loafey/grompt";
    # rrompt.url = "git+ssh://git@github.com/loafey/rrompt.git";
    queercat.url = "github:Elsa002/queercat";
    bunbun.url = "github:devraza/bunbun";

    stremio.url = "./stremio";
    display3d.url = "./display3d";

    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };


  outputs = { self, nixpkgs, flake-utils, ... }@inputs:
    with flake-utils.lib; eachSystem allSystems
      (system:
        let pkgs = nixpkgs.legacyPackages.${system}; in
        rec {
          packages = [
            inputs.queercat.defaultPackage."${pkgs.system}"
            inputs.grompt.defaultPackage."${pkgs.system}"
            # inputs.rrompt.defaultPackage."${pkgs.system}"
            inputs.stremio.defaultPackage."${pkgs.system}"
            inputs.display3d.defaultPackage."${pkgs.system}"
            inputs.bunbun.packages."${pkgs.system}".default
          ];
        }
      );
}
