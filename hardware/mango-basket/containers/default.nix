{ config, lib, pkgs, modulesPath, inputs, age, ... }: {
  imports = [ ./testing ];
  containers = {
    immich = import ./immich.nix;
    forgejo = import ./forgejo.nix;
    jellybean = import ./jellybean.nix;
    badger = import ./badger.nix;
    uptime-kuma = import ./uptime-kuma.nix;
    sap-box = import ./sap-box.nix;
    navi = (import ./navi.nix { inherit config; });
    rss = (import ./rss.nix { inherit config; });
  };

  services.gitea-actions-runner = import ./forgejo-runner.nix pkgs;
}
