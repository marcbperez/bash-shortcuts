#!/usr/bin/env bash

read -p "Do you want to enable bash-shortcuts? " -n 1 -r
if ! [[ $REPLY =~ ^[Yy]$ ]]; then echo && return; else echo; fi

shopt -s expand_aliases

function make_shortcuts() {
  SHORTCUTS="for f in $DIRNAME/$PREFIX/*-shortcuts.sh; do source \$f; done;"
}

DIRNAME="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

PREFIX="docker" && make_shortcuts
alias docker-shortcuts="$SHORTCUTS"
docker-shortcuts

PREFIX="git" && make_shortcuts
alias git-shortcuts="$SHORTCUTS"
git-shortcuts

PREFIX="os" && make_shortcuts
alias os-shortcuts="$SHORTCUTS"
os-shortcuts

PREFIX="vnc" && make_shortcuts
alias vnc-shortcuts="$SHORTCUTS"
vnc-shortcuts

os-user-ps1
