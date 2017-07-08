#!/usr/bin/env bash

function git-create-feature() {
  NAME="$1"
  FEATURENAME="feature-$NAME"

  if [ "$1" == "?" ] || [ -z "$NAME" ]; then
    echo "${FUNCNAME[0]} creates a new feature."
    echo "Usage: ${FUNCNAME[0]} [NAME]"
    echo "Example: ${FUNCNAME[0]} my-feature"
    return
  fi

  while true; do
    echo "Create $FEATURENAME?"
    echo "  - Y to continue"
    echo "  - E to exit"
    read -p ">> " ANSWER
    case $ANSWER in
      [Y]* ) break ;;
      [E]* ) return ;;
      * ) echo "Not a valid answer." ;;
    esac
  done

  git checkout develop &&
  git checkout -b "$FEATURENAME" develop &&
  git-work-on-feature "$NAME"
}

function git-work-on-feature() {
  NAME="$1"
  FEATURENAME="feature-$NAME"

  if [ "$1" == "?" ] || [ -z "$NAME" ]; then
    echo "${FUNCNAME[0]} checks out a feature."
    echo "Usage: ${FUNCNAME[0]} [NAME]"
    echo "Example: ${FUNCNAME[0]} my-feature"
    return
  fi

  while true; do
    echo "Work on $FEATURENAME?"
    echo "  - Y to continue"
    echo "  - E to exit"
    read -p ">> " ANSWER
    case $ANSWER in
      [Y]* ) break ;;
      [E]* ) return ;;
      * ) echo "Not a valid answer." ;;
    esac
  done

  git checkout "$FEATURENAME"

  while true; do
    echo "Are all the commits made on $FEATURENAME?"
    echo "  - S to run ./commit-script.sh"
    echo "  - A for the editor"
    echo "  - C for the commit tool"
    echo "  - M to merge back"
    echo "  - E to exit"
    read -p ">> " ANSWER
    case $ANSWER in
      [S]* ) source ./commit-script.sh ;;
      [A]* ) atom . ;;
      [C]* ) meld . ;;
      [M]* ) break ;;
      [E]* ) return ;;
      * ) echo "Not a valid answer." ;;
    esac
  done

  git-merge-back-feature "$NAME"
}

function git-merge-back-feature() {
  NAME="$1"
  FEATURENAME="feature-$NAME"

  if [ "$1" == "?" ] || [ -z "$NAME" ]; then
    echo "${FUNCNAME[0]} merges back a feature into develop."
    echo "Usage: ${FUNCNAME[0]} [NAME]"
    echo "Example: ${FUNCNAME[0]} my-feature"
    return
  fi

  while true; do
    echo "Merge back $FEATURENAME?"
    echo "  - Y to continue"
    echo "  - E to exit"
    read -p ">> " ANSWER
    case $ANSWER in
      [Y]* ) break ;;
      [E]* ) return ;;
      * ) echo "Not a valid answer." ;;
    esac
  done

  git checkout develop &&
  git merge --no-ff "$FEATURENAME" -m "Merged $FEATURENAME." &&
  git push origin "$FEATURENAME" develop
}
