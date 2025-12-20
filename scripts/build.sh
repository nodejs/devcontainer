#!/usr/bin/env bash

set -xe

cd /home/developer/nodejs/node
eval "$(direnv export bash)"

# Build tools and env variables (including e.g. BUILD_WITH=ninja) are
# defined in https://github.com/nodejs/node/blob/HEAD/shell.nix
make -C /home/developer/nodejs/node build-ci
