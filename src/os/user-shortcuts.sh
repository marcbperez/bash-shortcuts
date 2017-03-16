#!/usr/bin/env bash

function os-user-sudoer() {
  USERNAME="$1"

  if [ -z "$USERNAME" ]; then
    echo "Usage: ${FUNCNAME[0]} [USERNAME]"
    return
  fi

  sudo usermod -aG sudo $USERNAME
}
