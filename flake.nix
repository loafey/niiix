{
  description = "Loafeys NixOS Flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    git-flakes.url = "./git-flakes";
    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
    hyprland = {
      url = "github:hyprwm/Hyprland";
      # build with your own instance of nixpkgs
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, hyprland, ... }@inputs: {
    nixosConfigurations =
      let
        args = {
          inherit nixpkgs;
          userName = "loafey";
          inherit inputs;
          inherit home-manager;
        };
      in
      {
        "mango-vm" = import ./hardware-configs/setup-configuration.nix {
          inherit args;
          host = "mango-vm";
          extra-modules = [ ./desktops/gnome.nix ];
          path = ./hardware-configs/mango-vm;
        };

        "mango-lappy" = import ./hardware-configs/setup-configuration.nix {
          inherit args;
          host = "mango-lappy";
          extra-modules = [ ./desktops/hyprland.nix hyprland.nixosModules.default ];
          # extra-modules = [ ./desktops/gnome.nix ];
          path = ./hardware-configs/mango-lappy;
        };

        "mango-pc" = import ./hardware-configs/setup-configuration.nix {
          inherit args;
          host = "mango-pc";
          # extra-modules = [ ./desktops/gnome.nix ];
          extra-modules = [ ./desktops/hyprland.nix hyprland.nixosModules.default ];
          path = ./hardware-configs/mango-pc;
          extra-config = ./hardware-configs/mango-pc/nvidia.nix;
        };
      };
  };
}


