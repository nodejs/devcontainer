# Node.js Developer Container (`devcontainer`)

## Usage

### Setup

#### Running with Docker Desktop

To run locally on your machine, you'll want to install [Docker Desktop](https://www.docker.com/products/docker-desktop/) and start it up.

It's recommended to use Visual Studio Code with the [Dev Containers extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)
installed, but you can also run the container directly with Docker CLI or the [Dev Container CLI](https://github.com/devcontainers/cli), or attach any editor that supports the concept of [`devcontainers`](https://containers.dev/) to this container.

Once you've got Docker Desktop running, you can run the following command to pull and start the image:

```sh
docker pull nodejs/devcontainer:nightly
docker run -it nodejs/devcontainer:nightly /bin/bash
```

To use it as a devcontainer, create a `.devcontainer/devcontainer.json` file in the project with the following content:

```json
{
  "name": "Node.js Dev Container",
  "image": "nodejs/devcontainer:nightly",
  "workspaceMount": "source=${localWorkspaceFolder},target=/home/developer/nodejs/node,type=bind,consistency=cached",
  "workspaceFolder": "/home/developer/nodejs/node",
  "remoteUser": "developer",
  "mounts": [
    "source=build-cache,target=/home/developer/nodejs/node/out,type=volume"
  ],
  "postCreateCommand": ""
}
```

For example, to use it with Visual Studio Code, use the "Dev Containers: Reopen in Container" command from the Command Palette (`Ctrl+Shift+P` or `Cmd+Shift+P`). After the container is built and started, you should be inside the container with the project mounted in the working directory, while the build cache volume mounted at `out/` to speed up builds.

### Working in the Container

- The project is located at `/home/developer/nodejs/node`. After the container is started, you should be automatically placed in this directory.
- If you want to build the project in the container, run with `ninja` (rather than just `make`):
  - To build the release build, run `ninja -C out/Release`
  - The container comes with a release build that can be picked up by `ninja`. As long as your mounted local checkout is not too far behind the checkout in the container, incremental builds should be fast.

### Personal Configuration

Do this from your local system, not in the container. The `git` configuration will be used in the container since the project is mounted from your local system.

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
