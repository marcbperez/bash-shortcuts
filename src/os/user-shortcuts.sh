#!/usr/bin/env bash

function os-user-sudoer() {
  USERNAME="$1"

  if [ "$1" == "?" ] || [ -z "$USERNAME" ]; then
    echo "${FUNCNAME[0]} sets super-user privileges."
    echo "Usage: ${FUNCNAME[0]} [USERNAME]"
    echo "Example: ${FUNCNAME[0]} johndoe"
    return
  fi

  sudo usermod -aG sudo $USERNAME
}
