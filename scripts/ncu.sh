#!/usr/bin/env bash

set -e # Exit with nonzero exit code if anything fails 

npm install -g node-core-utils

ncu-config set upstream upstream
ncu-config set branch main
