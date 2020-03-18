#!/bin/zsh
# Script executed on docking
# Setup an external monitor and make it the primary one
XAUTHORITY=/home/piotr/.Xauthority DISPLAY=:0 xrandr --output HDMI1 --mode 1280x1024 --left-of eDP1 --output DP1-3 --mode 1680x1050 --left-of HDMI1 --primary
# Restart awesomewm
echo "awesome.restart()" | awesome-client
return 0
