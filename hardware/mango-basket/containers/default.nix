{ config, lib, pkgs, modulesPath, inputs, ... }: {
  imports = [ ./testing ];
  containers = {
    immich = import ./immich.nix;
    forgejo = import ./forgejo.nix;
    jellybean = import ./jellybean.nix;
    badger = import ./badger.nix;
    uptime-kuma = import ./uptime-kuma.nix;
  };

  services.gitea-actions-runner = import ./forgejo-runner.nix pkgs;
}
