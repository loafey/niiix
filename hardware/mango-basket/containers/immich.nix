{
  autoStart = true;
  privateNetwork = false;

  bindMounts = {
    "/run/secrets/immich" = {
      hostPath = "/mnt/fruit-bowl/services/secrets/immich";
      isReadOnly = true;
    };
    "/var/lib/immich" = {
      hostPath = "/mnt/fruit-bowl/services/immich-storage";
      isReadOnly = false;
    };
    "/var/lib/postgresql/14" = {
      hostPath = "/mnt/fruit-bowl/services/immich-db";
      isReadOnly = false;
    };
  };

  config = { config, pkgs, lib, ... }: {
    users.users.immich.uid = 999;
    users.users.postgres.uid = 71;

    services.postgresql.package = pkgs.postgresql_14;
    services.immich = {
      enable = true;
      port = 2283;
      host = "0.0.0.0";
      secretsFile = "/run/secrets/immich";
    };

    networking = {
      firewall.allowedTCPPorts = [ 2283 ];
      useHostResolvConf = lib.mkForce false;
    };

    services.resolved.enable = true;
    system.stateVersion = "24.11";
  };
}
