#!/usr/bin/env bash

set -xe

cd /home/developer/nodejs/node
eval "$(direnv export bash)"

ncu-config set upstream upstream
ncu-config set branch main
