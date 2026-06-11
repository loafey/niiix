{ ... }:
{
  imports = [
    ./metadata.nix
    ./proxy-manager.nix
    ./homeassistant.nix
    ./discodrome.nix
    ./zigbee2mqtt.nix
    ./fileflows.nix
    # ./img_dump.nix
  ];
}
