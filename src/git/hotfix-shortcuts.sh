#!/usr/bin/env bash

function git-create-hotfix() {
  VERSION="$1"
  HOTFIXNAME="hotfix-$VERSION"

  if [ -z "$VERSION" ]; then
    echo "Usage: ${FUNCNAME[0]} [VERSION]"
    return
  fi

  while true; do
    echo "Create $HOTFIXNAME?"
    echo "Answer Y to continue or E to exit."
    read -p ">> " ANSWER
    case $ANSWER in
      [Y]* ) break ;;
      [E]* ) return ;;
      * ) echo "Not a valid answer." ;;
    esac
  done

  git checkout -b "$HOTFIXNAME" master
  git-work-on-hotfix "$VERSION"
}

function git-work-on-hotfix() {
  VERSION="$1"
  HOTFIXNAME="hotfix-$VERSION"

  if [ -z "$VERSION" ]; then
    echo "Usage: ${FUNCNAME[0]} [VERSION]"
    return
  fi

  while true; do
    echo "Work on $HOTFIXNAME?"
    echo "Answer Y to continue or E to exit."
    read -p ">> " ANSWER
    case $ANSWER in
      [Y]* ) break ;;
      [E]* ) return ;;
      * ) echo "Not a valid answer." ;;
    esac
  done

  git checkout "$HOTFIXNAME"
  atom .

  while true; do
    echo "Is the version bumped and all the commits made on $HOTFIXNAME?"
    echo "C for the commit tool, M to merge back or E to exit."
    read -p ">> " ANSWER
    case $ANSWER in
      [C]* ) meld . ;;
      [M]* ) break ;;
      [E]* ) return ;;
      * ) echo "Not a valid answer." ;;
    esac
  done

  git-merge-back-hotfix "$VERSION"
}

function git-merge-back-hotfix() {
  VERSION="$1"
  HOTFIXNAME="hotfix-$VERSION"

  if [ -z "$VERSION" ]; then
    echo "Usage: ${FUNCNAME[0]} [VERSION]"
    return
  fi

  while true; do
    echo "Merge back $HOTFIXNAME?"
    echo "Answer Y to continue or E to exit."
    read -p ">> " ANSWER
    case $ANSWER in
      [Y]* ) break ;;
      [E]* ) return ;;
      * ) echo "Not a valid answer." ;;
    esac
  done

  git checkout master
  git merge --no-ff "$HOTFIXNAME" -m "Merged $HOTFIXNAME."
  git tag -a "$VERSION" -m "Tagged as $VERSION."
  git checkout develop
  git merge --no-ff "$HOTFIXNAME" -m "Merged $HOTFIXNAME."
  git push origin "$HOTFIXNAME" "$VERSION" master develop
}
