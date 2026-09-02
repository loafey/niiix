{
  config,
  lib,
  pkgs,
  modulesPath,
  inputs,
  age,
  ...
}:
{
  imports = [ ./testing ];
  containers = {
    immich = import ./immich.nix;
    forgejo = import ./forgejo.nix;
    jellybean = import ./jellybean.nix;
    badger = import ./badger.nix;
    uptime-kuma = import ./uptime-kuma.nix;
    navi = (import ./navi.nix { inherit config; });
    rss = (import ./rss.nix { inherit config; });
    karakeep = (import ./karakeep.nix { inherit config; });
    trilium = (import ./trilium.nix { inherit config; });
    mumriken = (import ./mumriken.nix);
    caddy = import ./caddy.nix;
  };

  services.gitea-actions-runner = import ./forgejo-runner.nix pkgs;
}
