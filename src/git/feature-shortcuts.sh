#!/usr/bin/env bash

function git-create-feature() {
  NAME="$1"
  FEATURENAME="feature-$NAME"

  if [ -z "$NAME" ]; then
    echo "Usage: ${FUNCNAME[0]} [NAME]"
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

  git checkout -b "$FEATURENAME" develop
  git-work-on-feature "$NAME"
}

function git-work-on-feature() {
  NAME="$1"
  FEATURENAME="feature-$NAME"

  if [ -z "$NAME" ]; then
    echo "Usage: ${FUNCNAME[0]} [NAME]"
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

  if [ -z "$NAME" ]; then
    echo "Usage: ${FUNCNAME[0]} [NAME]"
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

  git checkout develop
  git merge --no-ff "$FEATURENAME" -m "Merged $FEATURENAME."
  git push origin "$FEATURENAME" develop
}
