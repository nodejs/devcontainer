#!/usr/bin/env nix-shell
#! nix-shell --pure -i bash -I nixpkgs=/home/developer/nodejs/node/tools/nix/pkgs.nix /home/developer/nodejs/node/shell.nix

set -xe

make -C /home/developer/nodejs/node build-ci
