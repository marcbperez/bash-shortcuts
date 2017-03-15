#!/usr/bin/env bash

shopt -s expand_aliases

function make_shortcuts() {
  SHORTCUTS="\
  echo -e '\e[92mActivating $PREFIX shortcuts:\e[39m'; \
  for f in $DIRNAME/$PREFIX/*-shortcuts.sh; do source \$f; done; \
  typeset -f | grep \ \(\) | grep --color=never $PREFIX\-; "
}

DIRNAME="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

PREFIX="docker"
make_shortcuts
alias docker-shortcuts="$SHORTCUTS"
docker-shortcuts

PREFIX="git"
make_shortcuts
alias git-shortcuts="$SHORTCUTS"
git-shortcuts

PREFIX="os"
make_shortcuts
alias os-shortcuts="$SHORTCUTS"
os-shortcuts

PREFIX="vnc"
make_shortcuts
alias vnc-shortcuts="$SHORTCUTS"
vnc-shortcuts
