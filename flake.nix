{
  description = "Sampelampans NixOS Flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    git-flakes.url = "./git-flakes";
    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: {
    nixosConfigurations =
      let userName = "loafey"; in {
        "mango-vm" = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = {
            inherit inputs;
            host = "mango-vm";
            userName = userName;
            hardwareConfig = import ./hardware-configs/mango-vm/hardware.nix;
            serviceSetup = import ./hardware-configs/mango-vm/services.nix { inherit userName; };
          };
          modules = [ ./hardware-configs/base-configuration.nix ./desktops/gnome.nix ] ++ import ./home-setup.nix {
            userName = userName;
            home-manager = home-manager;
            inputs = inputs;
          };
        };

        "mango-lappy" = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = {
            inherit inputs;
            host = "mango-lappy";
            userName = userName;
            hardwareConfig = import ./hardware-configs/mango-lappy/hardware.nix;
            serviceSetup = import ./hardware-configs/mango-lappy/services.nix { inherit userName; };
          };
          modules = [ ./hardware-configs/base-configuration.nix ./desktops/gnome.nix ] ++ import ./home-setup.nix {
            userName = userName;
            home-manager = home-manager;
            inputs = inputs;
          };
        };
      };
  };
}


