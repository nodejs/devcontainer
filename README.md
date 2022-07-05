# Node.js Developer Container (`devcontainer`)

## End-user Setup

You will need to:
- Set the git `origin` to your own fork rather than `nodejs/node`
  - Example, where `USERNAME` is your GitHub username: `$ git remote set-url origin https://github.com/USERNAME/node.git`
  - Verify the remote is valid: `git remote -v`
- Set up your git name and email
  - `git config --global user.name "YOUR NAME"`
  - `git config --global user.email "YOUR@EMAIL.TLD"`
- Add your SSH key
 - Preferably one that's already [published to GitHub](https://docs.github.com/en/github/authenticating-to-github/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account)
 - Alternatively, you can install the `gh` CLI and run `gh auth login` to login and add a new key.

You will want to:
- Build Node.js with Ninja (rather than just `make`):
  - `/home/developer/nodejs/node/configure --ninja && make -C /home/developer/nodejs/node`

## Development

Some useful commands:
- `docker build .` - build the current Dockerfile
- `docker image ls` - list the images and IDs
- `docker run -it <image id> /bin/bash` - run a container and shell into it
- `docker tag <image id> devcontainer:nightly` - run to tag an image as `nightly`
