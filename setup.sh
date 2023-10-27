#!/bin/sh

CONFIG_PATH="$(realpath $(dirname $0))"
HARDWARE_CONFIG_PATH="${CONFIG_PATH}/hardware-configuration.nix"

nixos-generate-config --show-hardware-config > $HARDWARE_CONFIG_PATH

sudo nix-channel --add https://github.com/nix-community/home-manager/archive/release-23.05.tar.gz home-manager
sudo nix-channel --update

sudo rm /etc/nixos/configuration.nix
sudo ln -s "${CONFIG_PATH}/configuration.nix" /etc/nixos/configuration.nix 

sudo nixos-rebuild switch