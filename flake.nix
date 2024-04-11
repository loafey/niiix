{
  description = "Loafeys NixOS Flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    git-flakes.url = "path:/home/loafey/Git/niiix/git-flakes";
    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
    nix-index-database.url = "github:nix-community/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, nix-index-database, ... }@inputs: {
    nixosConfigurations =
      let
        args = {
          inherit nixpkgs;
          userName = "loafey";
          inherit inputs;
          inherit home-manager;
          index = nix-index-database.nixosModules.nix-index;
        };
      in
      {
        "mango-vm" = import ./hardware {
          inherit args;
          host = "mango-vm";
          extra-modules = [ ./desktops/gnome.nix ];
          path = ./hardware/mango-vm;
        };

        "mango-lappy" = import ./hardware {
          inherit args;
          host = "mango-lappy";
          extra-modules = [ ./desktops/plasma.nix ];
          path = ./hardware/mango-lappy;
        };

        "mango-pc" = import ./hardware {
          inherit args;
          host = "mango-pc";
          extra-modules = [ ./desktops/plasma.nix ];
          path = ./hardware/mango-pc;
          extra-config = ./hardware/mango-pc/nvidia.nix;
        };
      };
  };
}


