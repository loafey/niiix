#!/bin/sh

nixos-generate-config --show-hardware-config > hardware-configuration.nix

sudo nix-channel --add https://github.com/nix-community/home-manager/archive/release-23.05.tar.gz home-manager
sudo nix-channel --update

sudo rm /etc/nixos/configuration.nix
sudo ln -s /home/lemma/Git/niiix/configuration.nix /etc/nixos/configuration.nix 

sudo nixos-rebuild switch