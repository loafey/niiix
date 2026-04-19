{
  config,
  lib,
  pkgs,
  modulesPath,
  age,
  ...
}:
{
  services.prometheus = {
    enable = true;
    globalConfig.scrape_interval = "10s"; # "1m"
    scrapeConfigs = [
      {
        job_name = "node";
        static_configs = [
          {
            targets = [ "localhost:${toString config.services.prometheus.exporters.node.port}" ];
          }
        ];
      }
    ];
  };
  services.prometheus.exporters.node = {
    enable = true;
    port = 9000;
    enabledCollectors = [
      "ethtool"
      "softirqs"
      "systemd"
      "tcpstat"
      "wifi"
    ];
    extraFlags = [
      "--collector.ntp.protocol-version=4"
      "--no-collector.mdadm"
    ];
  };

  services.grafana = {
    enable = true;
    settings = {
      security.secret_key = config.age.secrets.grafana.path;
      server = {
        http_addr = "0.0.0.0";
        http_port = 3000;
        domain = "logs.loaf.boo";
        root_url = "https://logs.loaf.boo/"; # Not needed if it is `https://your.domain/`
        serve_from_sub_path = true;
      };
    };
  };

  services.loki = {
    enable = true;
    configuration = {
      auth_enabled = false;
      server.http_listen_port = 3100;

      # Minimal config: Store logs locally
      common = {
        path_prefix = "/var/lib/loki";
        storage.filesystem = {
          chunks_directory = "/var/lib/loki/chunks";
          rules_directory = "/var/lib/loki/rules";
        };
        replication_factor = 1;
        ring.kvstore.store = "inmemory";
      };
      schema_config.configs = [
        {
          from = "2024-01-01";
          store = "tsdb";
          object_store = "filesystem";
          schema = "v13"; # Use recent schema
          index = {
            prefix = "index_";
            period = "24h";
          };
        }
      ];
    };
  };

  services.fluent-bit = {
    enable = true;
    settings = {
      pipeline = {
        inputs = [
          {
            name = "systemd";
            tag = "sshd.*";
            systemd_filter = "_SYSTEMD_UNIT=sshd.service";
            read_from_tail = true;
          }
          {
            name = "systemd";
            tag = "fluent-bit.*";
            systemd_filter = "_SYSTEMD_UNIT=fluent-bit.service";
            read_from_tail = true;
          }
        ]
        ++ builtins.map (container: {
          name = "systemd";
          tag = "${container}.*";
          systemd_filter = "_SYSTEMD_UNIT=container@${container}.service";
          read_from_tail = true;
        }) (builtins.attrNames config.containers);
        outputs = [
          {
            match = "*";
            name = "loki";
            port = 3100;
          }
        ];
      };
      service = {
        grace = 30;
      };
    };
  };
}
