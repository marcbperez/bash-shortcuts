#!/usr/bin/env bash

function git-create-release() {
  VERSION="$1"
  RELEASENAME="release-$VERSION"

  if [ -z "$VERSION" ]; then
    echo "Usage: ${FUNCNAME[0]} [VERSION]"
    return
  fi

  while true; do
    echo "Create $RELEASENAME?"
    echo "Answer Y to continue or E to exit."
    read -p ">> " ANSWER
    case $ANSWER in
      [Y]* ) break ;;
      [E]* ) return ;;
      * ) echo "Not a valid answer." ;;
    esac
  done

  git checkout -b "$RELEASENAME" develop
  git-work-on-release "$VERSION"
}

function git-work-on-release() {
  VERSION="$1"
  RELEASENAME="release-$VERSION"

  if [ -z "$VERSION" ]; then
    echo "Usage: ${FUNCNAME[0]} [VERSION]"
    return
  fi

  while true; do
    echo "Work on $RELEASENAME?"
    echo "Answer Y to continue or E to exit."
    read -p ">> " ANSWER
    case $ANSWER in
      [Y]* ) break ;;
      [E]* ) return ;;
      * ) echo "Not a valid answer." ;;
    esac
  done

  git checkout "$RELEASENAME"
  atom .

  while true; do
    echo "Is the version bumped and all the commits made on $RELEASENAME?"
    echo "C for the commit tool, M to merge back or E to exit."
    read -p ">> " ANSWER
    case $ANSWER in
      [C]* ) meld . ;;
      [M]* ) break ;;
      [E]* ) return ;;
      * ) echo "Not a valid answer." ;;
    esac
  done

  git-merge-back-release "$VERSION"
}

function git-merge-back-release() {
  VERSION="$1"
  RELEASENAME="release-$VERSION"

  if [ -z "$VERSION" ]; then
    echo "Usage: ${FUNCNAME[0]} [VERSION]"
    return
  fi

  while true; do
    echo "Merge back $RELEASENAME?"
    echo "Answer Y to continue or E to exit."
    read -p ">> " ANSWER
    case $ANSWER in
      [Y]* ) break ;;
      [E]* ) return ;;
      * ) echo "Not a valid answer." ;;
    esac
  done

  git checkout develop
  git merge --no-ff "$RELEASENAME" -m "Merged $RELEASENAME."
  git push origin "$RELEASENAME" develop

  git-merge-back-develop "$VERSION"
}

function git-merge-back-develop() {
  VERSION="$1"

  if [ -z "$VERSION" ]; then
    echo "Usage: ${FUNCNAME[0]} [VERSION]"
    return
  fi

  while true; do
    echo "Merge back develop version $VERSION?"
    echo "Answer Y to continue or E to exit."
    read -p ">> " ANSWER
    case $ANSWER in
      [Y]* ) break ;;
      [E]* ) return ;;
      * ) echo "Not a valid answer." ;;
    esac
  done

  git checkout master
  git merge --no-ff develop -m "Merged development version $VERSION."
  git tag -a "$VERSION" -m "Tagged as $VERSION."
  git push origin "$VERSION" master
}
