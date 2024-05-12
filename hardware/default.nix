{ host, extra-modules, path, args, extra-config ? { } }: args.nixpkgs.lib.nixosSystem {
  system = "x86_64-linux";
  specialArgs = {
    inherit host;
    inputs = args.inputs;
    userName = args.userName;
    hardwareConfig = import (path + /hardware.nix);
    serviceSetup = import (path + /services.nix) { userName = args.userName; };
    inherit extra-config;
  };
  modules = [
    ./base.nix
    args.index
    args.flatpak
    args.vscode-server
  ] ++ extra-modules ++ import ./home.nix {
    userName = args.userName;
    home-manager = args.home-manager;
    inputs = args.inputs;
  };
}
