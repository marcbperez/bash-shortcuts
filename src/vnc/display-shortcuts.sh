#!/usr/bin/env bash

function vnc-virtual-display() {
  HRES="$1"
  VRES="$2"

  if [ -z "$HRES" ] || [ -z "$VRES" ]; then
    echo "Usage: ${FUNCNAME[0]} [HRES] [VRES]"
    return
  fi

  MDEF=$(xrandr --listactivemonitors | grep '*' | cut -d ' ' -f6)
  MODELINE="$(gtf $HRES $VRES 50 | grep Modeline | cut -d ' ' -f4-)"
  MODENAME="$(echo $MODELINE | cut -d ' ' -f1 | tr '"' ' ')"

  xrandr --newmode $MODELINE
  xrandr --addmode VIRTUAL1 $MODENAME
  xrandr --output VIRTUAL1 --mode $MODENAME --right-of $MDEF

  XPOS=$(xrandr --listactivemonitors | grep VIRTUAL1 | cut -d '/' -f3 | cut -d \
    '+' -f2)
  YPOS=$(xrandr --listactivemonitors | grep VIRTUAL1 | cut -d '/' -f3 | cut -d \
    '+' -f3 | cut -d ' ' -f1)

  x11vnc -clip ${HRES}x${VRES}+$XPOS+$YPOS -usepw -noxdamage -noxfixes -nowf \
    -nowcr -nocursorshape -nocursorpos -cursor_drag -cursor arrow
}
