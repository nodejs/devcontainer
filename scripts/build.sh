#!/usr/bin/env bash

set -e # Exit with nonzero exit code if anything fails 

~/nodejs/node/configure --ninja --debug && make -C ~/nodejs/node
