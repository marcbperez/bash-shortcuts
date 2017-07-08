#!/usr/bin/env bash

function os-clean-history() {
  if [ "$1" == "?" ]; then
    echo "${FUNCNAME[0]} clears the shell history."
    echo "Usage: ${FUNCNAME[0]}"
    echo "Example: ${FUNCNAME[0]}"
    return
  fi

  cat /dev/null > ~/.bash_history && history -c && exit
}

function os-clean-packages() {
  if [ "$1" == "?" ]; then
    echo "${FUNCNAME[0]} clears unused system packages."
    echo "Usage: ${FUNCNAME[0]}"
    echo "Example: ${FUNCNAME[0]}"
    return
  fi

  sudo apt autoremove
}
