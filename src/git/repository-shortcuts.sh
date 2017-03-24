#!/usr/bin/env bash

function git-start-from-origin() {
  ORIGIN="$1"

  if [ -z "$ORIGIN" ]; then
    echo "Usage: ${FUNCNAME[0]} [ORIGIN]"
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

  git init && \
  git remote add origin "$ORIGIN" && \
  git-create-common-branches
}

function git-create-common-branches() {
  FIRST_COMMIT_MESSAGE="$1"

  if [ -z "$FIRST_COMMIT_MESSAGE" ]; then
    FIRST_COMMIT_MESSAGE="Added .gitignore list for untracked resources."
    echo "Usage: ${FUNCNAME[0]} [FIRST_COMMIT_MESSAGE]"
    echo "Using default first commit message: $FIRST_COMMIT_MESSAGE"
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

  touch .gitignore && \
  echo "" > .gitignore && \
  git add .gitignore && \
  git commit .gitignore -m "$FIRST_COMMIT_MESSAGE" && \
  git push -u origin master && \
  git checkout -b develop master && \
  git push origin develop
}

function git-commit-date() {
  COMMIT_DATE="$1"

  if [ -z "$COMMIT_DATE" ]; then
    echo "Usage: ${FUNCNAME[0]} [COMMIT_DATE]"
    return
  fi

  export {GIT_AUTHOR_DATE,GIT_COMMITTER_DATE}="$COMMIT_DATE"
}

function git-reset-branch() {
  BRANCH="$1"
  COMMIT_ID="$2"

  if [ -z "$BRANCH" ] || [ -z "$COMMIT_ID" ]; then
    echo "Usage: ${FUNCNAME[0]} [BRANCH] [COMMIT_ID]"
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

  git checkout $BRANCH && \
  git reset --hard $COMMIT_ID && \
  git push -f origin $BRANCH
}
