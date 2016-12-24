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

function os-install-basics() {
  sudo apt-get update && sudo apt-get dist-upgrade

  sudo apt-get install \
    vim tree wget \ # Essential terminal tools.
    git gitk meld \ # Git and related utilities.
    x11vnc ssvnc \ # VNC server and client.
    virtualbox \ # Easy to use virtualization utility.
    keepassx \ # Password and encrypted storage.
    kicad # CAD program for circuit design.

  # Install Atom.
  wget https://atom.io/download/deb -O /tmp/atom.deb
  sudo dpkg -i /tmp/atom.deb
  sudo apt-get install -f
  rm /tmp/atom.deb
}
