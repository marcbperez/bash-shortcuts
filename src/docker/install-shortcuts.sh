#!/usr/bin/env bash

function docker-install-ce() {
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

  sudo apt-key fingerprint 0EBFCD88
  sudo add-apt-repository \
    "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

  sudo apt-get update && sudo apt-get install docker-ce
}

function docker-install-compose() {
  docker-install-ce

  sudo sh -c \
    "curl -L https://github.com/docker/compose/releases/download/1.12.0/docker-compose-$(uname -s)-$(uname -m) > \
    /usr/local/bin/docker-compose"
  sudo chmod +x /usr/local/bin/docker-compose

  docker-compose --version
}
