#!/usr/bin/env bash

function git-create-release() {
  VERSION="$1"
  RELEASENAME="release-$VERSION"

  if [ "$1" == "?" ] || [ -z "$VERSION" ]; then
    echo "${FUNCNAME[0]} creates a new release."
    echo "Usage: ${FUNCNAME[0]} [VERSION]"
    echo "Example: ${FUNCNAME[0]} 0.1.0"
    return
  fi

  while true; do
    echo "Create $RELEASENAME?"
    echo "  - Y to continue"
    echo "  - X to exit"
    read -p ">> " ANSWER
    case $ANSWER in
      [Y]* ) break ;;
      [X]* ) return ;;
      * ) echo "Not a valid answer." ;;
    esac
  done

  git checkout develop &&
  git checkout -b "$RELEASENAME" develop &&
  git-work-on-release "$VERSION"
}

function git-work-on-release() {
  VERSION="$1"
  RELEASENAME="release-$VERSION"

  if [ "$1" == "?" ] || [ -z "$VERSION" ]; then
    echo "${FUNCNAME[0]} checks out a release."
    echo "Usage: ${FUNCNAME[0]} [VERSION]"
    echo "Example: ${FUNCNAME[0]} 0.1.0"
    return
  fi

  while true; do
    echo "Work on $RELEASENAME?"
    echo "  - Y to continue"
    echo "  - X to exit"
    read -p ">> " ANSWER
    case $ANSWER in
      [Y]* ) break ;;
      [X]* ) return ;;
      * ) echo "Not a valid answer." ;;
    esac
  done

  git checkout "$RELEASENAME"

  while true; do
    echo "Are all the commits made on $FEATURENAME?"
    echo "  - A for the editor"
    echo "  - C for the commit tool"
    echo "  - D to set the commit date"
    echo "  - M to merge back"
    echo "  - S to run ./commit-script.sh"
    echo "  - X to exit"
    read -p ">> " ANSWER
    case $ANSWER in
      [A]* ) atom . ;;
      [C]* ) meld . ;;
      [D]* ) read -p "Set date: " NEWDATE && git-commit-date "$NEWDATE" ;;
      [M]* ) break ;;
      [S]* ) source ./commit-script.sh ;;
      [X]* ) return ;;
      * ) echo "Not a valid answer." ;;
    esac
  done

  git-merge-back-release "$VERSION"
}

function git-merge-back-release() {
  VERSION="$1"
  RELEASENAME="release-$VERSION"

  if [ "$1" == "?" ] || [ -z "$VERSION" ]; then
    echo "${FUNCNAME[0]} merges back a hotfix into develop."
    echo "Usage: ${FUNCNAME[0]} [VERSION]"
    echo "Example: ${FUNCNAME[0]} 0.1.0"
    return
  fi

  while true; do
    echo "Merge back $RELEASENAME?"
    echo "  - Y to continue"
    echo "  - X to exit"
    read -p ">> " ANSWER
    case $ANSWER in
      [Y]* ) break ;;
      [X]* ) return ;;
      * ) echo "Not a valid answer." ;;
    esac
  done

  git checkout develop &&
  git merge --no-ff "$RELEASENAME" -m "Merged $RELEASENAME." &&
  git push origin "$RELEASENAME" develop &&
  git-merge-back-develop "$VERSION"
}

function git-merge-back-develop() {
  VERSION="$1"

  if [ "$1" == "?" ] || [ -z "$VERSION" ]; then
    echo "${FUNCNAME[0]} merges back develop and tags master."
    echo "Usage: ${FUNCNAME[0]} [VERSION]"
    echo "Example: ${FUNCNAME[0]} 0.1.0"
    return
  fi

  while true; do
    echo "Merge back develop version $VERSION?"
    echo "  - Y to continue"
    echo "  - X to exit"
    read -p ">> " ANSWER
    case $ANSWER in
      [Y]* ) break ;;
      [X]* ) return ;;
      * ) echo "Not a valid answer." ;;
    esac
  done

  git checkout master &&
  git merge --no-ff develop -m "Merged development version $VERSION." &&
  git tag -a "$VERSION" -m "Tagged as $VERSION." &&
  git push origin "$VERSION" master
}
