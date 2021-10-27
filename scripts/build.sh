#!/usr/bin/env bash

set -e # Exit with nonzero exit code if anything fails 

/home/developer/nodejs/node/configure --ninja && make -C /home/developer/nodejs/node
