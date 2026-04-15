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

}
