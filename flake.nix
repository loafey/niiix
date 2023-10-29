{
  description = "Sampelampans NixOS Flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    grompt.url = "github:samhamnam/grompt";
    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: {
    nixosConfigurations =
      let
        default-modules = [
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.lemma = import ./home.nix {
              nix-vscode-extensions = inputs.nix-vscode-extensions;
            };
          }
        ];
      in
      {
        "mango-lemma" = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = {
            inherit inputs;
            host = "mango-lemma";
            userName = "lemma";
          };
          modules = [ ./configuration.nix ] ++ default-modules;
        };
      };
  };
}
