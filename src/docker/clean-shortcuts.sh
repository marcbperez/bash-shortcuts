#!/usr/bin/env bash

function docker-stop-containers() {
  if [ "$1" == "?" ]; then
    echo "${FUNCNAME[0]} stops all Docker containers."
    echo "Usage: ${FUNCNAME[0]}"
    echo "Example: ${FUNCNAME[0]}"
    return
  fi

  sudo docker stop $(sudo docker ps -a -q)
}

function docker-remove-containers() {
  if [ "$1" == "?" ]; then
    echo "${FUNCNAME[0]} removes all Docker containers."
    echo "Usage: ${FUNCNAME[0]}"
    echo "Example: ${FUNCNAME[0]}"
    return
  fi

  sudo docker rm $(sudo docker ps -a -q)
}

function docker-remove-images() {
  if [ "$1" == "?" ]; then
    echo "${FUNCNAME[0]} removes all Docker images."
    echo "Usage: ${FUNCNAME[0]}"
    echo "Example: ${FUNCNAME[0]}"
    return
  fi

  sudo docker rmi $(sudo docker images -q)
}

function docker-remove-volumes() {
  if [ "$1" == "?" ]; then
    echo "${FUNCNAME[0]} removes all Docker volumes."
    echo "Usage: ${FUNCNAME[0]}"
    echo "Example: ${FUNCNAME[0]}"
    return
  fi

  sudo docker volume rm $(sudo docker volume ls -qf dangling=true)
}

function docker-clean() {
  if [ "$1" == "?" ]; then
    echo "${FUNCNAME[0]} cleans the Docker environment."
    echo "Usage: ${FUNCNAME[0]}"
    echo "Example: ${FUNCNAME[0]}"
    return
  fi

  while true; do
    echo "Stop all containers?"
    echo "  - Y to continue"
    echo "  - X to exit"
    read -p ">> " ANSWER
    case $ANSWER in
      [Y]* ) break ;;
      [X]* ) return ;;
      * ) echo "Not a valid answer." ;;
    esac
  done

  docker-stop-containers

  while true; do
    echo "Remove all containers?"
    echo "  - Y to continue"
    echo "  - X to exit"
    read -p ">> " ANSWER
    case $ANSWER in
      [Y]* ) break ;;
      [X]* ) return ;;
      * ) echo "Not a valid answer." ;;
    esac
  done

  docker-remove-containers

  while true; do
    echo "Remove all images?"
    echo "  - Y to continue"
    echo "  - X to exit"
    read -p ">> " ANSWER
    case $ANSWER in
      [Y]* ) break ;;
      [X]* ) return ;;
      * ) echo "Not a valid answer." ;;
    esac
  done

  docker-remove-images

  while true; do
    echo "Remove all volumes?"
    echo "  - Y to continue"
    echo "  - X to exit"
    read -p ">> " ANSWER
    case $ANSWER in
      [Y]* ) break ;;
      [X]* ) return ;;
      * ) echo "Not a valid answer." ;;
    esac
  done

  docker-remove-volumes

  while true; do
    echo "Prune system?"
    echo "  - Y to continue"
    echo "  - X to exit"
    read -p ">> " ANSWER
    case $ANSWER in
      [Y]* ) break ;;
      [X]* ) return ;;
      * ) echo "Not a valid answer." ;;
    esac
  done

  sudo docker system prune -af
}
