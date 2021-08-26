#!/usr/bin/env bash

set -e # Exit with nonzero exit code if anything fails 

cd ~/nodejs
git clone https://github.com/nodejs/node.git
cd ~/nodejs/node
git remote add upstream https://github.com/nodejs/node.git
git fetch upstream
