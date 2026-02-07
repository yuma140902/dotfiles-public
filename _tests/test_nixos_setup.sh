#!/usr/bin/env bash

set -eux
set -o pipefail

cd $HOME/repos/dotfiles-public/

# TODO: nixos setup test
# nixos-rebuild switch --flake '.'

nix run home-manager/master -- switch --flake . --impure
