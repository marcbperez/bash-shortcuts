#!/usr/bin/env bash

function vnc-display-on() {
  HRES="$1"
  VRES="$2"
  VIRTNO="$3"
  POS="$4"

  if [ "$1" == "?" ] || [ -z "$HRES" ] || [ -z "$VRES" ] || [ -z "$VIRTNO" ] ||
  [ -z "$POS" ]; then
    echo "${FUNCNAME[0]} starts a virtual display and its VNC connection."
    echo "Usage: ${FUNCNAME[0]} [HRES] [VRES] [VIRTNO] [POS]"
    echo "Example: ${FUNCNAME[0]} 600 400 1 right"
    return
  fi

  MDEFAULT="$(xrandr --listactivemonitors | grep '*' | cut -d ' ' -f6)" &&
  MODELINE="$(gtf $HRES $VRES 50 | grep Modeline | cut -d ' ' -f4-)" &&
  MODENAME="\"$(echo $MODELINE | cut -d ' ' -f1 | tr -d '"')\"" &&

  xrandr --newmode $MODELINE &&
  xrandr --addmode VIRTUAL${VIRTNO} $MODENAME &&
  xrandr --output VIRTUAL${VIRTNO} --mode $MODENAME --${POS}-of $MDEFAULT &&

  XPOS=$(xrandr --listactivemonitors | grep VIRTUAL${VIRTNO} | cut -d '/' -f3 |
    cut -d '+' -f2) &&
  YPOS=$(xrandr --listactivemonitors | grep VIRTUAL${VIRTNO} | cut -d '/' -f3 |
    cut -d '+' -f3 | cut -d ' ' -f1) &&

  x11vnc -rfbport 591${VIRTNO} -clip ${HRES}x${VRES}+${XPOS}+${YPOS} -usepw \
    -noxdamage -noxfixes -nowf -nowcr -nocursorshape -nocursorpos -cursor_drag \
    -cursor arrow &&

  vnc-display-off $HRES $VRES $VIRTNO
}

function vnc-display-off() {
  HRES="$1"
  VRES="$2"
  VIRTNO="$3"

  if [ "$1" == "?" ] || [ -z "$HRES" ] || [ -z "$VRES" ] || [ -z "$VIRTNO" ]
  then
    echo "${FUNCNAME[0]} stops and deletes a virtual display."
    echo "Usage: ${FUNCNAME[0]} [HRES] [VRES] [VIRTNO]"
    echo "Example: ${FUNCNAME[0]} 600 400 1"
    return
  fi

  MODELINE="$(gtf $HRES $VRES 50 | grep Modeline | cut -d ' ' -f4-)" &&
  MODENAME="\"$(echo $MODELINE | cut -d ' ' -f1 | tr -d '"')\"" &&

  xrandr --output VIRTUAL${VIRTNO} --off &&
  xrandr --delmode VIRTUAL${VIRTNO} $MODENAME &&
  xrandr --rmmode $MODENAME &&
  xrandr -s 0
}
