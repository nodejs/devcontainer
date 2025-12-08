FROM ubuntu:latest AS build

ARG USER_UID=900
ARG USER_GID=$USER_UID

# Create the non-root user and grant NOPASSWD sudo
RUN groupadd --gid $USER_GID developer
RUN useradd --uid $USER_UID --gid $USER_GID --shell /bin/bash --create-home developer

# Install sudo first
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends ca-certificates curl git git-restore-mtime sudo xz-utils

# No Sudo Prompt - thanks Electron for this
RUN echo 'developer ALL=NOPASSWD: ALL' >> /etc/sudoers.d/developer
RUN echo 'Defaults    env_keep += "DEBIAN_FRONTEND"' >> /etc/sudoers.d/env_keep

ENV DEBIAN_FRONTEND=1

# Copy scripts and make them executable by both root and developer
COPY --chown=root:developer --chmod=0755 ./scripts/ /home/developer/scripts/

USER developer
RUN /home/developer/scripts/clone.sh

# Installing Nix and Cachix
RUN curl -L https://github.com/cachix/install-nix-action/raw/HEAD/install-nix.sh | \
      USER=developer \
      INPUT_SET_AS_TRUSTED_USER=true \
      INPUT_ENABLE_KVM=true \
      INPUT_EXTRA_NIX_CONFIG= \
      INPUT_INSTALL_OPTIONS= \
      RUNNER_TEMP=$(mktemp -d) GITHUB_ENV=/dev/null GITHUB_PATH=/dev/null bash
ENV NIX_PROFILES="/nix/var/nix/profiles/default /home/developer/.nix-profile"
ENV NIX_SSL_CERT_FILE=/etc/ssl/certs/ca-certificates.crt
ENV PATH="/home/developer/.nix-profile/bin:${PATH}"
RUN nix-env -iA cachix -f https://cachix.org/api/v1/install
RUN USER=developer cachix use nodejs

RUN /home/developer/scripts/build.sh

WORKDIR /home/developer/nodejs/node
RUN /home/developer/scripts/install-node.sh
RUN /home/developer/scripts/ncu.sh

# We pass `--impure` so the locally installed `node` build is available on the PATH.
ENTRYPOINT ["/home/developer/.nix-profile/bin/nix-shell", "--impure", "-I", "nixpkgs=/home/developer/nodejs/node/tools/nix/pkgs.nix"]
