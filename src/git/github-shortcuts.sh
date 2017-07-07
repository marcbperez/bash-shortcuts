#!/usr/bin/env bash

function git-github-id() {
  USERNAME="$1"
  USEREMAIL="$USERNAME@users.noreply.github.com"

  if [ "$1" == "?" ] || [ -z "$USERNAME" ]; then
    echo "${FUNCNAME[0]} sets a Github username and email."
    echo "Usage: ${FUNCNAME[0]} [USERNAME]"
    echo "Example: ${FUNCNAME[0]} johndoe"
    return
  fi

  git config --global user.name "$USERNAME" &&
  git config --global user.name &&
  git config --global user.email "$USEREMAIL" &&
  git config --global user.email
}
