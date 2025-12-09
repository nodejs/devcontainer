#!/usr/bin/env bash

set -xe

mkdir -p /home/developer/nodejs
git clone https://github.com/nodejs/node.git --depth 1 /home/developer/nodejs/node
(
  cd /home/developer/nodejs/node
  git remote add upstream https://github.com/nodejs/node.git
  git restore-mtime  # Restore file modification times to commit times for build cache to match.
)
