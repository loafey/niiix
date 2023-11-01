{ host, extra-modules, path, args }: args.nixpkgs.lib.nixosSystem {
  system = "x86_64-linux";
  specialArgs = {
    inherit host;
    inputs = args.inputs;
    userName = args.userName;
    hardwareConfig = import (path + /hardware.nix);
    serviceSetup = import (path + /services.nix) { userName = args.userName; };
  };
  modules = [ ./base-configuration.nix ] ++ extra-modules ++ import ./home-setup.nix {
    userName = args.userName;
    home-manager = args.home-manager;
    inputs = args.inputs;
  };
}
