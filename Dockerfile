ARG IMAGE_TAG=latest

FROM node:${IMAGE_TAG}
ENV DEBIAN_FRONTEND=noninteractive
WORKDIR /home/

ENTRYPOINT ["./scripts/setup-origin.sh"]

RUN scripts/install.sh
RUN scripts/mkdir.sh
RUN scripts/ccache.sh
RUN scripts/npm.sh
RUN scripts/fetch.sh

ENV PATH /usr/lib/ccache:$PATH

RUN scripts/build.sh