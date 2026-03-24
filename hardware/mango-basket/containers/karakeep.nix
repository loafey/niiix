{ config, ... }:
{
  autoStart = true;
  privateNetwork = true;
  hostAddress = "192.168.100.52";
  localAddress = "192.168.100.53";
  hostAddress6 = "fc00::33";
  localAddress6 = "fc00::34";

  bindMounts = {
    "${config.age.secrets.rss.path}".isReadOnly = true;
  };

  config =
    {
      config,
      pkgs,
      lib,
      ...
    }:
    {
      nixpkgs.config.allowUnfree = true;

      hardware.graphics = {
        enable = true;
        enable32Bit = true;
      };

      services = {
        karakeep = {
          enable = true;
          extraEnvironment = {
            NEXT_CACHE_DIR = "/var/cache/next";
            CRAWLER_HTTP_PROXY = "http://localhost:1055/";
            CRAWLER_HTTPS_PROXY = "http://localhost:1055/";
            CRAWLER_ALLOWED_INTERNAL_HOSTNAMES = ".";
            # OLLAMA_BASE_URL = "localhost:11434";
            # INFERENCE_TEXT_MODEL = "llama3.2:3b";
            # INFERENCE_IMAGE_MODEL = "llava:7b";
            # EMBEDDING_TEXT_MODEL = "qwen3-embedding:4b";
          };
        };

        # ollama = {
        #   enable = true;
        #   loadModels = [
        #     "llama3.2:3b"
        #     "llava:7b"
        #     "qwen3-embedding:4b"
        #   ];
        # };
        # open-webui.enable = true;

        tailscale = {
          enable = true;
          interfaceName = "userspace-networking";
          extraDaemonFlags = [
            "--socks5-server=localhost:1055"
            "--outbound-http-proxy-listen=localhost:1055"
          ];
        };
      };
      networking = {
        firewall.enable = false;
        useHostResolvConf = lib.mkForce false;
      };

      services.resolved.enable = true;
      system.stateVersion = "24.11";
    };
}
