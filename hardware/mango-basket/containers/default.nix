{ config, lib, pkgs, modulesPath, ... }: {
  containers = {
    immich = import ./immich.nix;
    forgejo = import ./forgejo.nix;
  };
}
