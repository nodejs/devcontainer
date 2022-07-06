# Node.js Developer Container (`devcontainer`)

## Usage

### Setup

#### Running with Docker Desktop

To run locally on your machine, you'll want to install [Docker Desktop](https://www.docker.com/products/docker-desktop/) and start it up.

Once you've got Docker Destop running, you can run the following command to pull and start the image:

```sh
docker pull nodejs/devcontainer:nightly
docker run -it nodejs/devcontainer:nightly /bin/bash
```

Once you've run those commands, you'll be in a shell inside the running container. If you need to escape, type `exit`. You should be good to jump to [Working in the Container](#working-in-the-container).

### Working in the Container

- The project is located at `/home/developer/nodejs/node`.
  - Once this directory is your active directory, you should be good to go.
  - If you want to build the project in the container, run with ninja (rather than just make):
    - `/home/developer/nodejs/node/configure --ninja && make -C /home/developer/nodejs/node`
- You should be able to attach any editor that supports the concept of [`devcontainers`](https://containers.dev/) to this 

### Personal Configuration

Assuming you've already got the Docker container running:

- Set the git `origin` to your own fork rather than `nodejs/node`
  - Example, where `USERNAME` is your GitHub username: `$ git remote set-url origin https://github.com/USERNAME/node.git`
  - Verify the remote is valid: `git remote -v`
- Set up your git name and email
  - `git config --global user.name "YOUR NAME"`
  - `git config --global user.email "YOUR@EMAIL.TLD"`
- Add your SSH key
 - Preferably one that's already [published to GitHub](https://docs.github.com/en/github/authenticating-to-github/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account)
 - Alternatively, you can install the [`gh` CLI](https://cli.github.com/) and run `gh auth login` to login and add a new key.

## Development

Some useful commands:
- `docker build .` - build the current Dockerfile
- `docker image ls` - list the images and IDs
- `docker run -it <image id> /bin/bash` - run a container and shell into it
- `docker tag <image id> devcontainer:nightly` - run to tag an image as `nightly`


### Tips and Tricks for Debugging Failed Builds and Otherwise Developing in This Repo

Some notes on what's been helpful:

- Break up the `RUN` statement in the [Dockerfile][] into multiple `RUN` statements, each containing a single command. This provies more precise information about what exactly is failing if the Docker build fails and isn't providing helpful output.
- Sometimes removing the `RUN` statement in the [Dockerfile][] and running `docker build`, running the built container, and individually running each command in the running container is a better development experience than working outside of the built container.

[Dockerfile]: ./Dockerfile
