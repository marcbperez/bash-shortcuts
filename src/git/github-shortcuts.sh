#!/usr/bin/env bash

function git-github-id() {
  USERNAME="$1"
  USEREMAIL="$USERNAME@users.noreply.github.com"

  if [ -z "$USERNAME" ]; then
    echo "Usage: ${FUNCNAME[0]} [USERNAME]"
    return
  fi

  git config --global user.name "$USERNAME"
  git config --global user.name
  
  git config --global user.email "$USEREMAIL"
  git config --global user.email
}
