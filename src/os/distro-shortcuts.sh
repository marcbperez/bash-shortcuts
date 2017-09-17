#!/usr/bin/env bash

function os-distro-disk() {
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
