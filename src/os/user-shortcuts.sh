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

function os-user-ps1() {
  if [ "$1" == "?" ]; then
    echo "${FUNCNAME[0]} sets PS1."
    echo "Usage: ${FUNCNAME[0]}"
    echo "Example: ${FUNCNAME[0]}"
    return
  fi

  PS1='\w : '
}
