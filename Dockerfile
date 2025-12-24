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

# Installing Nix using the same script test-shared workflow uses upstream.
# See https://github.com/nodejs/node/blob/HEAD/.github/workflows/test-shared.yml
# See https://github.com/cachix/install-nix-action/blob/HEAD/install-nix.sh
RUN curl -L "https://github.com/$(sed -nE 's#.*(cachix/install-nix-action)@([a-f0-9]+).*#\1/raw/\2#p' /home/developer/nodejs/node/.github/workflows/test-shared.yml)/install-nix.sh" | \
      USER=developer \
      INPUT_SET_AS_TRUSTED_USER=true \
      INPUT_ENABLE_KVM=true \
      INPUT_EXTRA_NIX_CONFIG= \
      INPUT_INSTALL_OPTIONS= \
      RUNNER_TEMP=$(mktemp -d) GITHUB_ENV=/dev/null GITHUB_PATH=/dev/null bash
ENV NIX_PROFILES="/nix/var/nix/profiles/default /home/developer/.nix-profile"
ENV NIX_SSL_CERT_FILE=/etc/ssl/certs/ca-certificates.crt
ENV PATH="/home/developer/.local/bin:/home/developer/.nix-profile/bin:${PATH}"
# Installing Cachix, and set it up to reuse binaries build by the CI.
RUN nix-env -iA cachix -f https://cachix.org/api/v1/install
RUN USER=developer cachix use nodejs

# Installing direnv
RUN nix profile add nixpkgs#nix-direnv nixpkgs#direnv -I nixpkgs=/home/developer/nodejs/node/tools/nix/pkgs.nix
RUN mkdir -p /home/developer/.config/direnv && \
    echo 'source $HOME/.nix-profile/share/nix-direnv/direnvrc' > /home/developer/.config/direnv/direnvrc
RUN echo 'eval "$(direnv hook bash)"' >> /home/developer/.bashrc

# Setting up direnv for the local clone, see envrc/README.md for more info
COPY --chown=root:developer --chmod=0644 ./envrc/ /home/developer/envrc/
ARG IMAGE_VARIANT=static-libs
RUN cp "/home/developer/envrc/${IMAGE_VARIANT}.envrc" /home/developer/nodejs/node/.envrc
RUN direnv allow /home/developer/nodejs/node

RUN /home/developer/scripts/build.sh

WORKDIR /home/developer/nodejs/node
RUN /home/developer/scripts/install-node.sh
RUN /home/developer/scripts/ncu.sh

# direnv will automatically load the nix environment when entering the directory
ENTRYPOINT ["/bin/bash", "-l"]
