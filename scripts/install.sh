#!/usr/bin/env bash

set -e # Exit with nonzero exit code if anything fails 

package_list="
  build-essential \
  ccache \
  curl \
  nano \
  python3 \
  python-setuptools \
  python3-pip \
  ninja-build \
  g++ \
  sudo \
  make \
  git \
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

# No Sudo Prompt - thanks Electron for this
echo 'developer ALL=NOPASSWD: ALL' >> /etc/sudoers.d/50-developer
echo 'Defaults    env_keep += "DEBIAN_FRONTEND"' >> /etc/sudoers.d/env_keep
