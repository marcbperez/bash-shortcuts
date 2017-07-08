#!/usr/bin/env bash

function os-install-disk() {
  DEVICE="$1"
  IMAGE_URL="$2"
  IMAGE_FILE="/tmp/os.iso"

  if [ "$1" == "?" ] || [ -z "$DEVICE" ] || [ -z "$IMAGE_URL" ]; then
    echo "${FUNCNAME[0]} makes an installation disk from an online image."
    echo "Usage: ${FUNCNAME[0]} [DEVICE] [IMAGE_URL]"
    echo "Example: ${FUNCNAME[0]} /dev/sdc https://www.example.com/image.iso'"
    return
  fi

  sudo umount $DEVICE* &&
  wget $IMAGE_URL -O $IMAGE_FILE &&
  sudo dd bs=4M if=$IMAGE_FILE of=$DEVICE status=progress &&
  sudo sync &&
  rm $IMAGE_FILE
}

function os-install-updates() {
  if [ "$1" == "?" ]; then
    echo "${FUNCNAME[0]} upgrades the system."
    echo "Usage: ${FUNCNAME[0]}"
    echo "Example: ${FUNCNAME[0]}"
    return
  fi

  sudo apt update && sudo apt dist-upgrade
}

function os-install-basics() {
  if [ "$1" == "?" ]; then
    echo "${FUNCNAME[0]} installs common packages."
    echo "Usage: ${FUNCNAME[0]}"
    echo "Example: ${FUNCNAME[0]}"
    return
  fi

  sudo add-apt-repository ppa:cwchien/gradle &&
  os-install-updates &&
  sudo apt install \
    vim tree wget curl \
    git gitk meld \
    x11vnc ssvnc \
    virtualbox \
    keepassx \
    kicad freecad \
    chromium-browser \
    default-jdk gradle-3.5.1 &&
  wget https://atom.io/download/deb -O /tmp/atom.deb &&
  sudo dpkg -i /tmp/atom.deb &&
  sudo apt install -f &&
  rm /tmp/atom.deb &&
  docker-install-compose &&
  os-clean-packages
}
