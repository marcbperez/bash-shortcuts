#!/usr/bin/env bash

function git-start-from-origin() {
  ORIGIN="$1"

  if [ "$1" == "?" ] || [ -z "$ORIGIN" ]; then
    echo "${FUNCNAME[0]} initializes a repository from an existing origin."
    echo "Usage: ${FUNCNAME[0]} [ORIGIN]"
    echo "Example: ${FUNCNAME[0]} https://github.com/johndoe/my-repository"
    return
  fi

  while true; do
    echo "Start repository from origin $ORIGIN?"
    echo "  - Y to continue"
    echo "  - E to exit"
    read -p ">> " ANSWER
    case $ANSWER in
      [Y]* ) break ;;
      [E]* ) return ;;
      * ) echo "Not a valid answer." ;;
    esac
  done

  git init &&
  git remote add origin "$ORIGIN" &&
  git-create-common-branches
}

function git-create-common-branches() {
  FIRST_COMMIT_MESSAGE="$1"

  if [ "$1" == "?" ]; then
    echo "${FUNCNAME[0]} initializes master and develop branches."
    echo "Usage: ${FUNCNAME[0]} [FIRST_COMMIT_MESSAGE]"
    echo "Example: ${FUNCNAME[0]} 'Added ignore list for untracked resources.'"
    return
  fi

  if [ -z "$FIRST_COMMIT_MESSAGE" ]; then
    FIRST_COMMIT_MESSAGE="Added ignore list for untracked resources."
  fi

  while true; do
    echo "Create master and develop branches with a blank .gitignore?"
    echo "  - Y to continue"
    echo "  - E to exit"
    read -p ">> " ANSWER
    case $ANSWER in
      [Y]* ) break ;;
      [E]* ) return ;;
      * ) echo "Not a valid answer." ;;
    esac
  done

  touch .gitignore &&
  echo "" > .gitignore &&
  git add .gitignore &&
  git commit .gitignore -m "$FIRST_COMMIT_MESSAGE" &&
  git push -u origin master &&
  git checkout -b develop master &&
  git push origin develop
}

function git-commit-date() {
  COMMIT_DATE="$1"

  if [ "$1" == "?" ] || [ -z "$COMMIT_DATE" ]; then
    echo "${FUNCNAME[0]} sets the commit date."
    echo "Usage: ${FUNCNAME[0]} [COMMIT_DATE]"
    echo "Example: ${FUNCNAME[0]} '2017-05-13 21:01:56'"
    return
  fi

  export {GIT_AUTHOR_DATE,GIT_COMMITTER_DATE}="$COMMIT_DATE"
}

function git-reset-branch() {
  BRANCH="$1"
  COMMIT_ID="$2"

  if [ "$1" == "?" ] || [ -z "$BRANCH" ] || [ -z "$COMMIT_ID" ]; then
    echo "${FUNCNAME[0]} sets the commit date."
    echo "Usage: ${FUNCNAME[0]} [BRANCH] [COMMIT_ID]"
    echo "Example: ${FUNCNAME[0]} develop b16a6"
    return
  fi

  while true; do
    echo "Do you really want to reset and push the branch?"
    echo "  - Y to continue"
    echo "  - E to exit"
    read -p ">> " ANSWER
    case $ANSWER in
      [Y]* ) break ;;
      [E]* ) return ;;
      * ) echo "Not a valid answer." ;;
    esac
  done

  git checkout $BRANCH &&
  git reset --hard $COMMIT_ID &&
  git push -f origin $BRANCH
}
