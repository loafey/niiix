{ ... }:
{
  imports = [
    ./metadata.nix
    ./proxy-manager.nix
    ./homeassistant.nix
    ./discodrome.nix
    ./zigbee2mqtt.nix
  ];
}
