#!/usr/bin/env bash

function docker-stop-containers() {
  sudo docker stop $(sudo docker ps -a -q)
}

function docker-remove-containers() {
  sudo docker rm $(sudo docker ps -a -q)
}

function docker-remove-images() {
  sudo docker rmi $(sudo docker images -q)
}

function docker-clean() {
  docker-stop-containers
  docker-remove-containers
  docker-remove-images
}
