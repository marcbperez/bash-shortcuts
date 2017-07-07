#!/usr/bin/env bash

function git-create-hotfix() {
  VERSION="$1"
  HOTFIXNAME="hotfix-$VERSION"

  if [ "$1" == "?" ] || [ -z "$VERSION" ]; then
    echo "${FUNCNAME[0]} creates a new hotfix."
    echo "Usage: ${FUNCNAME[0]} [VERSION]"
    echo "Example: ${FUNCNAME[0]} 0.0.1"
    return
  fi

  while true; do
    echo "Create $HOTFIXNAME?"
    echo "  - Y to continue"
    echo "  - E to exit"
    read -p ">> " ANSWER
    case $ANSWER in
      [Y]* ) break ;;
      [E]* ) return ;;
      * ) echo "Not a valid answer." ;;
    esac
  done

  git checkout master &&
  git checkout -b "$HOTFIXNAME" master &&
  git-work-on-hotfix "$VERSION"
}

function git-work-on-hotfix() {
  VERSION="$1"
  HOTFIXNAME="hotfix-$VERSION"

  if [ "$1" == "?" ] || [ -z "$VERSION" ]; then
    echo "${FUNCNAME[0]} checks out a hotfix."
    echo "Usage: ${FUNCNAME[0]} [VERSION]"
    echo "Example: ${FUNCNAME[0]} 0.0.1"
    return
  fi

  while true; do
    echo "Work on $HOTFIXNAME?"
    echo "  - Y to continue"
    echo "  - E to exit"
    read -p ">> " ANSWER
    case $ANSWER in
      [Y]* ) break ;;
      [E]* ) return ;;
      * ) echo "Not a valid answer." ;;
    esac
  done

  git checkout "$HOTFIXNAME"

  while true; do
    echo "Are all the commits made on $HOTFIXNAME?"
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

  git-merge-back-hotfix "$VERSION"
}

function git-merge-back-hotfix() {
  VERSION="$1"
  HOTFIXNAME="hotfix-$VERSION"

  if [ "$1" == "?" ] || [ -z "$VERSION" ]; then
    echo "${FUNCNAME[0]} merges back a hotfix into master and develop."
    echo "Usage: ${FUNCNAME[0]} [VERSION]"
    echo "Example: ${FUNCNAME[0]} 0.0.1"
    return
  fi

  while true; do
    echo "Merge back $HOTFIXNAME?"
    echo "  - Y to continue"
    echo "  - E to exit"
    read -p ">> " ANSWER
    case $ANSWER in
      [Y]* ) break ;;
      [E]* ) return ;;
      * ) echo "Not a valid answer." ;;
    esac
  done

  git checkout master &&
  git merge --no-ff "$HOTFIXNAME" -m "Merged $HOTFIXNAME." &&
  git tag -a "$VERSION" -m "Tagged as $VERSION." &&
  git checkout develop &&
  git merge --no-ff "$HOTFIXNAME" -m "Merged $HOTFIXNAME." &&
  git push origin "$HOTFIXNAME" "$VERSION" master develop
}
