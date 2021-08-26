# Node.js Developer Environment (`devenv`)

## End-user Setup

You will need to:
- Set the git `origin` to your own fork rather than `nodejs/node`
- Set up your git name and email
- Add your SSH key (preferably one that's already [published to GitHub](https://docs.github.com/en/github/authenticating-to-github/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account))

You will want to:
- Build Node.js with Ninja (rather than just `make`):
  - `~/nodejs/node/configure --ninja --debug && make -C ~/nodejs/node`
