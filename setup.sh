#!/bin/sh

CONFIG_PATH="$(realpath $(dirname $0))"

# nixos-generate-config --show-hardware-config > $HARDWARE_CONFIG_PATH
#cp /etc/nixos/hardware-configuration.nix hardware-configuration.nix
#echo "REMEMBER TO SETUP YOUR HARDWARE AND HOST!"
sudo nix-channel --add https://nixos.org/channels/nixos-unstable nixos
sudo nix-channel --update

sudo rm /etc/nixos/flake.nix
sudo rm /etc/nixos/configuration.nix
sudo ln -s "${CONFIG_PATH}/hardware-configs/base-configuration.nix" /etc/nixos/configuration.nix 
sudo ln -s "${CONFIG_PATH}/flake.nix" /etc/nixos/flake.nix 


sudo nixos-rebuild boot
