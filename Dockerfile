FROM ubuntu:latest AS build

ARG USER_UID=900
ARG USER_GID=$USER_UID

# Create the non-root user and grant NOPASSWD sudo
RUN groupadd --gid $USER_GID developer
RUN useradd --uid $USER_UID --gid $USER_GID --shell /bin/bash --create-home developer

# Install sudo first
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends sudo

# No Sudo Prompt - thanks Electron for this
RUN echo 'developer ALL=NOPASSWD: ALL' >> /etc/sudoers.d/developer
RUN echo 'Defaults    env_keep += "DEBIAN_FRONTEND"' >> /etc/sudoers.d/env_keep

ENV DEBIAN_FRONTEND=1
ENV PATH=/usr/lib/ccache:$PATH

COPY --chown=root:developer ./scripts/ /home/developer/scripts/
RUN /home/developer/scripts/install.sh
RUN /home/developer/scripts/mkdir.sh
RUN /home/developer/scripts/ccache.sh
RUN /home/developer/scripts/clone.sh
RUN /home/developer/scripts/build.sh
RUN make install -C /home/developer/nodejs/node
RUN /home/developer/scripts/ncu.sh

WORKDIR /home/developer/nodejs/node
