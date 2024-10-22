{
  description = "Other flakes :^)";

  inputs = {
    grompt.url = "github:loafey/grompt";
    grompt-prompt.url = "github:loafey/grompt-prompt";
    nfs-check.url = "github:loafey/nfs-check";
    # rrompt.url = "git+ssh://git@github.com/loafey/rrompt.git";
    queercat.url = "github:Elsa002/queercat";
    bunbun.url = "github:devraza/bunbun";
    # hey.url = "git+https://git.blek.codes/blek/hey";

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
            inputs.nfs-check.defaultPackage."${pkgs.system}"
            inputs.grompt-prompt.defaultPackage."${pkgs.system}"
            inputs.stremio.defaultPackage."${pkgs.system}"
            inputs.display3d.defaultPackage."${pkgs.system}"
            inputs.bunbun.packages."${pkgs.system}".default
            # inputs.hey.defaultPackage."${pkgs.system}"
          ];
        }
      );
}
