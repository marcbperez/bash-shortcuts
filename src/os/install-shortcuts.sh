#!/usr/bin/env bash

function os-install-disk() {
  DEVICE="$1"
  IMAGE_URL="$2"
  IMAGE_FILE="/tmp/os.iso"

  if [ -z "$DEVICE" ] || [ -z "$IMAGE_URL" ]; then
    echo "Usage: ${FUNCNAME[0]} [DEVICE] [IMAGE_URL]"
    return
  fi

  sudo umount $DEVICE*
  wget $IMAGE_URL -O $IMAGE_FILE
  sudo dd bs=4M if=$IMAGE_FILE of=$DEVICE status=progress
  sudo sync
  rm $IMAGE_FILE
}

function os-install-updates() {
  sudo apt-get update && sudo apt-get dist-upgrade
}

function os-install-basics() {
  sudo add-apt-repository ppa:cwchien/gradle
  os-install-updates

  sudo apt-get install \
    vim tree wget curl \
    git gitk meld \
    x11vnc ssvnc \
    virtualbox \
    keepassx \
    kicad freecad \
    chromium-browser \
    default-jdk gradle-3.4

  wget https://atom.io/download/deb -O /tmp/atom.deb
  sudo dpkg -i /tmp/atom.deb
  sudo apt-get install -f
  rm /tmp/atom.deb

  sudo apt-get autoremove
}
