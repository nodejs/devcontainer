#!/usr/bin/env bash

set -xe

cd /home/developer/nodejs/node
eval "$(direnv export bash)"

make -C /home/developer/nodejs/node build-ci
