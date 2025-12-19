#!/usr/bin/env bash

set -xe

cd /home/developer/nodejs/node
eval "$(direnv export bash)"

# BUILD_WTIH=ninja is set in https://github.com/nodejs/node/blob/HEAD/shell.nix
make -C /home/developer/nodejs/node build-ci
