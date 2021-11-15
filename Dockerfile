FROM ubuntu:latest AS build

RUN groupadd --gid 1000 developer \
  && useradd --uid 1000 --gid developer --shell /bin/bash --create-home developer

ENV DEBIAN_FRONTEND=1
ENV PATH /usr/lib/ccache:$PATH

COPY --chown=root:developer ./scripts/ /home/developer/scripts/
RUN /home/developer/scripts/install.sh && /home/developer/scripts/mkdir.sh && /home/developer/scripts/ccache.sh && /home/developer/scripts/clone.sh && /home/developer/scripts/build.sh && make install -C /home/developer/nodejs/node && /home/developer/scripts/ncu.sh

WORKDIR /home/developer/nodejs/node
