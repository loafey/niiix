{ config, lib, pkgs, modulesPath, inputs, ... }: {
  imports = [ ./testing ];
  containers = {
    immich = import ./immich.nix;
    forgejo = import ./forgejo.nix;
    jellybean = import ./jellybean.nix;
  };

  services.gitea-actions-runner = import ./forgejo-runner.nix pkgs;
}
