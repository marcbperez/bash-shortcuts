#!/usr/bin/env bash

function os-install-updates() {
  if [ "$1" == "?" ]; then
    echo "${FUNCNAME[0]} upgrades the system."
    echo "Usage: ${FUNCNAME[0]}"
    echo "Example: ${FUNCNAME[0]}"
    return
  fi

  sudo apt update && sudo apt dist-upgrade
}

function os-install-all() {
  if [ "$1" == "?" ]; then
    echo "${FUNCNAME[0]} upgrades and installs all package sets."
    echo "Usage: ${FUNCNAME[0]}"
    echo "Example: ${FUNCNAME[0]}"
    return
  fi

  os-install-updates &&
  os-install-basics &&
  os-install-engineering &&
  os-install-development &&
  os-install-virtualhost &&
  os-clean-packages
}

function os-install-basics() {
  if [ "$1" == "?" ]; then
    echo "${FUNCNAME[0]} installs common packages."
    echo "Usage: ${FUNCNAME[0]}"
    echo "Example: ${FUNCNAME[0]}"
    return
  fi

  sudo apt install vim tree wget curl \
    openssh-server x11vnc ssvnc \
    keepassx chromium-browser
}

function os-install-engineering() {
  if [ "$1" == "?" ]; then
    echo "${FUNCNAME[0]} installs engineering packages."
    echo "Usage: ${FUNCNAME[0]}"
    echo "Example: ${FUNCNAME[0]}"
    return
  fi

  sudo apt install kicad freecad arduino
}

function os-install-development() {
  if [ "$1" == "?" ]; then
    echo "${FUNCNAME[0]} installs development packages."
    echo "Usage: ${FUNCNAME[0]}"
    echo "Example: ${FUNCNAME[0]}"
    return
  fi

  sudo add-apt-repository ppa:cwchien/gradle &&
  sudo apt update &&
  sudo apt install git gitk meld default-jdk gradle-3.5.1 &&
  wget https://atom.io/download/deb -O /tmp/atom.deb &&
  sudo dpkg -i /tmp/atom.deb &&
  sudo apt install -f &&
  rm /tmp/atom.deb
}

function os-install-virtualhost() {
  if [ "$1" == "?" ]; then
    echo "${FUNCNAME[0]} installs virtual host packages."
    echo "Usage: ${FUNCNAME[0]}"
    echo "Example: ${FUNCNAME[0]}"
    return
  fi

  sudo apt install virtualbox &&
  docker-install-compose
}
