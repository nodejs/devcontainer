# Node.js Developer Environment (`devenv`)

## End-user Setup

You will need to:
- Set the git `origin` to your own fork rather than `nodejs/node`
- Set up your git name and email
- Add your SSH key (preferably one that's already [published to GitHub](https://docs.github.com/en/github/authenticating-to-github/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account))

You will want to:
- Build Node.js with Ninja (rather than just `make`):
  - `/home/developer/nodejs/node/configure --ninja && make -C ~/nodejs/node`

## Development

Some useful commands:
- `docker build .` - build the current Dockerfile
- `docker image ls` - list the images and IDs
- `docker run -it <image id> /bin/bash` - run a container and shell into it
- `docker tag <image id> devenv:latest` - run to tag an image as latest