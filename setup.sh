#!/bin/sh

CONFIG_PATH="$(realpath $(dirname $0))"
HARDWARE_CONFIG_PATH="${CONFIG_PATH}/hardware-configuration.nix"

nixos-generate-config --show-hardware-config > $HARDWARE_CONFIG_PATH
sudo nix-channel --add https://nixos.org/channels/nixos-unstable nixos
sudo nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
sudo nix-channel --update

sudo rm /etc/nixos/flake.nix
sudo rm /etc/nixos/configuration.nix
sudo ln -s "${CONFIG_PATH}/configuration.nix" /etc/nixos/configuration.nix 
sudo ln -s "${CONFIG_PATH}/flake.nix" /etc/nixos/flake.nix 


sudo nixos-rebuild switch