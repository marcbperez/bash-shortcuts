#!/usr/bin/env bash

function docker-install-ce() {
  ARCH="$1"

  if [ "$1" == "?" ] || [ -z "$ARCH" ]; then
    echo "${FUNCNAME[0]} install Docker CE."
    echo "Usage: ${FUNCNAME[0]} [ARCH]"
    echo "Example: ${FUNCNAME[0]} amd64"
    return
  fi

  curl -fsSL https://download.docker.com/linux/ubuntu/gpg |
    sudo apt-key add - &&
  sudo apt-key fingerprint 0EBFCD88 &&
  sudo add-apt-repository \
    "deb [arch=${ARCH}] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" &&
  sudo apt-get update && sudo apt-get install docker-ce
}

function docker-install-compose() {
  ARCH="$1"
  VERSION="$2"

  if [ "$1" == "?" ] || [ -z "$ARCH" ] || [ -z "$VERSION" ]; then
    echo "${FUNCNAME[0]} install Docker Compose with Docker CE."
    echo "Usage: ${FUNCNAME[0]} [ARCH] [VERSION]"
    echo "Example: ${FUNCNAME[0]} amd64 1.19.0"
    return
  fi

  docker-install-ce $ARCH &&
  sudo sh -c \
    "curl -L https://github.com/docker/compose/releases/download/${VERSION}/docker-compose-$(uname -s)-$(uname -m) > /usr/local/bin/docker-compose" &&
  sudo chmod +x /usr/local/bin/docker-compose
}
