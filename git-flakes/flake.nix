{
  description = "Other flakes :^)";

  inputs = {
    grompt.url = "github:samhamnam/grompt";
    queercat.url = "github:Elsa002/queercat";

    stremio.url = "./stremio";

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
            inputs.stremio.defaultPackage."${pkgs.system}"
          ];
        }
      );
}
