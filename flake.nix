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
      let userName = "lemma"; in {
        "mango-vm" = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = {
            inherit inputs;
            host = "mango-vm";
            userName = userName;
            hardwareConfig = ./hardware-configs/mango-vm.nix;
          };
          modules = [ ./configuration.nix ] ++ import ./home-setup.nix {
            userName = userName;
            home-manager = home-manager;
            inputs = inputs;
          };
        };
      };
  };
}


