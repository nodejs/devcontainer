#!/usr/bin/env bash

set -xe

# NODE_REF pins the image to one nodejs/node commit.
# This is specified by the repository_dispatch event from nodejs/node (the commit associated with the successful daily build) or the manual `node_ref` input from workflow_dispatch.
# Otherwise, it defaults to the latest commit on `main` branch.
# This script is responsible for loosely validating the specified value as at least being a valid commit SHA. If a SHA not available in the nodejs/node repo is provided, the `git fetch` step will fail loudly.
if [ -n "${NODE_REF:-}" ] && [[ ! "$NODE_REF" =~ ^[0-9a-f]{40}$ ]]; then
  echo "NODE_REF must be a full commit SHA, got: $NODE_REF" >&2
  exit 1
fi

# Equivalent to `git clone --depth 1`, except it also respects NODE_REF.
# Fetching only that commit keeps its history connected to main, so a later `git pull` fast-forwards.
mkdir -p /home/developer/nodejs/node
(
  cd /home/developer/nodejs/node
  git init --initial-branch=main
  git remote add --track main origin https://github.com/nodejs/node.git
  git fetch --depth 1 origin "${NODE_REF:-main}"
  git reset --hard FETCH_HEAD
  git update-ref refs/remotes/origin/main FETCH_HEAD
  git branch --set-upstream-to=origin/main main
  git remote add upstream https://github.com/nodejs/node.git
  git restore-mtime  # Restore file modification times to commit times for build cache to match.
)
