#!/bin/zsh
# Script executed on undocking
# Disconnect the external monitor
XAUTHORITY=/home/piotr/.Xauthority DISPLAY=:0 xrandr --output HDMI1 --off --output DP1-3 --off --output eDP1 --primary
echo "awesome.restart()" | awesome-client 2>/dev/null
return 0
