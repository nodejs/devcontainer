#!/usr/bin/env nix-shell
#! nix-shell --pure -i bash -I nixpkgs=/home/developer/nodejs/node/tools/nix/pkgs.nix /home/developer/nodejs/node/shell.nix

set -xe

ncu-config set upstream upstream
ncu-config set branch main
