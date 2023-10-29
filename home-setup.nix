{ userName, home-manager, inputs }: [
  home-manager.nixosModules.home-manager
  {
    home-manager.useGlobalPkgs = true;
    home-manager.useUserPackages = true;
    home-manager.users.${userName} = import ./dotfiles/home.nix {
      inherit inputs;
    };
  }
]
