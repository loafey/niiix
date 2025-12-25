{
  autoStart = true;
  privateNetwork = false;

  bindMounts = {
    "/var/lib/forgejo" = {
      hostPath = "/mnt/fruit-bowl/services/forgejo";
      isReadOnly = false;
    };
    "/run/secrets/forgejo" = {
      hostPath = "/mnt/fruit-bowl/services/secrets/forgejo";
      isReadOnly = true;
    };
  };

  config = { config, pkgs, lib, ... }: {
    services.forgejo = {
      enable = true;
      package = pkgs.forgejo;
      lfs.enable = true;
      settings = {
        DEFAULT = {
          APP_SLOGAN = "Beyond Bread. We Bake.";
          APP_NAME = "Bakery";
        };

        server = let addr = "git.loaf.boo";
        in {
          DOMAIN = addr;
          ROOT_URL = "https://${addr}/";
          HTTP_PORT = 2300;
          SSH_PORT = 2222;
          SSH_LISTEN_PORT = 2222;
          START_SSH_SERVER = true;
        };

        service.DISABLE_REGISTRATION = true;
        database = {
          DB_TYPE = "sqlite3";
          PATH = lib.mkForce "/var/lib/forgejo/data/gitea.db";
          NAME = "gitea";
          USER = "root";
          LOG_SQL = "false";
          SCHEMA = "";
          SSL_MODE = "disable";
          passwordFile = "/run/secrets/forgejo";
        };
        # Add support for actions, based on act: https://github.com/nektos/act
        # actions = {
        #   ENABLED = true;
        #   DEFAULT_ACTIONS_URL = "github";
        # };
      };
    };

    networking = {
      firewall.allowedTCPPorts = [ 2300 2222 ];
      useHostResolvConf = lib.mkForce false;
    };

    services.resolved.enable = true;
    system.stateVersion = "24.11";
  };
}
