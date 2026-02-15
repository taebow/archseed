#!/bin/bash

sleep 3
CARD=2
CONTROL="PCM"

# Initial sync on script start
VOL=$(wpctl get-volume @DEFAULT_SINK@ | awk '{printf "%.0f%%", $2 * 100}')
amixer -c $CARD sset $CONTROL 0%
amixer -c $CARD sset Master 100%

# Monitor for changes
pactl subscribe | grep --line-buffered "'change' on sink" | while read -r UNUSED_LINE; do
  VOL=$(wpctl get-volume @DEFAULT_SINK@ | awk '{printf "%.0f%%", $2 * 100}')
  # Clamp to 0-100% (PipeWire allows >100%, but ALSA hardware maxes at 100%)
  if [ "${VOL%?}" -gt 100 ]; then
    VOL="100%"
  fi
  amixer -c $CARD sset $CONTROL $VOL
done


