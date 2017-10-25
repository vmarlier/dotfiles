#!/bin/bash

killall -q polybar

while pgrep -x polybar >/dev/null; do sleep 1; done

MONITOR=eDP1 polybar example &
#MONITOR=eDP1 polybar -c /home/robot/.config/polybar/config2 example &
