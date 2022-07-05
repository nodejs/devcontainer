#!/usr/bin/env bash

set -e # Exit with nonzero exit code if anything fails 

cd /home/developer/nodejs
git clone https://github.com/nodejs/node.git --single-branch --branch main --depth 1
cd /home/developer/nodejs/node
git remote add upstream https://github.com/nodejs/node.git
git fetch upstream
