#MONITOR=eDP1 polybar -c /home/robot/.config/polybar/config2 example &
#!/bin/sh

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -x polybar >/dev/null; do sleep 1; done

MONITOR=eDP1 polybar top &
