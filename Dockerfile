FROM ubuntu:latest AS build

RUN groupadd --gid 1000 developer \
  && useradd --uid 1000 --gid developer --shell /bin/bash --create-home developer

ENV DEBIAN_FRONTEND=1
ENV PATH /usr/lib/ccache:$PATH

COPY ./scripts/ ./scripts/
RUN ./scripts/install.sh
RUN ./scripts/mkdir.sh && ./scripts/ccache.sh && ./scripts/clone.sh
RUN ./scripts/build.sh
RUN make install -C ~/nodejs/node
RUN ./scripts/ncu.sh