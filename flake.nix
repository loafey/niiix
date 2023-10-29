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
      let userName = "loafey"; in {
        "mango-vm" = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = {
            inherit inputs;
            host = "mango-vm";
            userName = userName;
            hardwareConfig = import ./hardware-configs/mango-vm.nix;
            serviceSetup = {
              xserver.enable = true;
              #xserver.displayManager.sddm.enable = true;
              #xserver.desktopManager.plasma5.enable = true;
              xserver.displayManager.gdm.enable = true;
              xserver.desktopManager.gnome.enable = true;

              xserver.displayManager.autoLogin.enable = true;
              xserver.displayManager.autoLogin.user = userName;
              printing.enable = true;

              pipewire = {
                enable = true;
                alsa.enable = true;
                alsa.support32Bit = true;
                pulse.enable = true;
              };

              xserver = {
                layout = "se";
                xkbVariant = "";
              };
            };
          };
          modules = [ ./configuration.nix ] ++ import ./home-setup.nix {
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
            hardwareConfig = import ./hardware-configs/mango-lappy.nix;
            serviceSetup = {
              xserver.enable = true;
              #xserver.displayManager.sddm.enable = true;
              #xserver.desktopManager.plasma5.enable = true;
              xserver.displayManager.gdm.enable = true;
              xserver.desktopManager.gnome.enable = true;

              xserver.displayManager.autoLogin.enable = true;
              xserver.displayManager.autoLogin.user = userName;
              printing.enable = true;

              pipewire = {
                enable = true;
                alsa.enable = true;
                alsa.support32Bit = true;
                pulse.enable = true;
              };

              xserver = {
                layout = "se";
                xkbVariant = "";
              };
            };
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


