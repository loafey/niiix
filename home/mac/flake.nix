{
  description = "Home Manager configuration of loafey";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    git-flakes.url = "github:loafey/git-flakes";
    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
  };

  outputs =
    { nixpkgs, home-manager, git-flakes, ... }:
    let
      pkgs = import nixpkgs { system = "aarch64-darwin"; config.allowUnfree = true; };
    in
    {
      homeConfigurations."loafey" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        # Specify your home configuration modules here, for example,
        # the path to your home.nix.
        modules = [ ./macos.nix ];

        # Optionally use extraSpecialArgs
        extraSpecialArgs = {
          inherit git-flakes;
        };
        # to pass through arguments to home.nix
      };
    };
}
