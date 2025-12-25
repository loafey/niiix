{ config, lib, pkgs, modulesPath, ... }: {
  # Immich
  containers.immich = import ./immich.nix;
}
