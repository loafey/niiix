{ pkgs, ... }: {
  package = pkgs.forgejo-runner;
  instances.default = {
    enable = true;
    name = "rubber-ducky";
    url = "https://git.loaf.boo";
    tokenFile = "/mnt/fruit-bowl/services/secrets/forgejo-runner";
    labels = [
      "ubuntu-latest:docker://node:16-bullseye"
      "ubuntu-22.04:docker://node:16-bullseye"
      "ubuntu-20.04:docker://node:16-bullseye"
    ];
  };
}
