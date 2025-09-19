#!/usr/bin/env bash

set -e # Exit with nonzero exit code if anything fails 

package_list="
  build-essential \
  ccache \
  curl \
  nano \
  python3 \
  python3-pip \
  python-is-python3 \
  ninja-build \
  g++ \
  gcc \
  g++-12 \
  gcc-12 \
  make \
  git \
  pkg-config \
  locales \
  gpg \
  wget"

# Install Packages
apt-get update
DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends $package_list

# set up GitHub CLI resistry stuff to get gh CLI
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | gpg --dearmor -o /usr/share/keyrings/githubcli-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | tee /etc/apt/sources.list.d/github-cli.list > /dev/null
gh_package_list="gh"
apt-get update
DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends $gh_package_list
