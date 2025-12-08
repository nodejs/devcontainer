#!/usr/bin/env bash

set -e # Exit with nonzero exit code if anything fails 

mkdir -p /home/developer/nodejs
cd /home/developer/nodejs
git clone https://github.com/nodejs/node.git --depth 1
cd /home/developer/nodejs/node
git remote add upstream https://github.com/nodejs/node.git
