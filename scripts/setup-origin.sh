#!/usr/bin/env bash

set -e # Exit with nonzero exit code if anything fails 

if [[ -z "${ORIGIN_URL}" ]]
then
    echo "ORIGIN_URL is not set"
else
  git remote set-url origin ${ORIGIN_URL}
fi
