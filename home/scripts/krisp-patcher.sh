#!/bin/sh

nix-shell -p python3 python3Packages.pyelftools python3Packages.capstone --run "python krisp-patcher.py ~/.config/discord/*/modules/discord_krisp/discord_krisp.node"