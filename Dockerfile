FROM node:latest
WORKDIR /home/
RUN curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | gpg --dearmor -o /usr/share/keyrings/githubcli-archive-keyring.gpg && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | tee /etc/apt/sources.list.d/github-cli.list > /dev/null && apt-get update && apt-get install -y && apt-get install gh python3 g++ make git -y && npm install -g node-core-utils
RUN mkdir workspace && cd workspace && git clone https://github.com/nodejs/node.git && cd node && git remote add upstream https://github.com/nodejs/node.git && git fetch upstream
RUN cd workspace/node && ./configure