#!/usr/bin/env bash

set -e # Exit with nonzero exit code if anything fails

make install PREFIX=/home/developer/.local -C /home/developer/nodejs/node
echo '' >> /home/developer/.bashrc
echo 'export PATH=/home/developer/.local/bin:$PATH' >> /home/developer/.bashrc
