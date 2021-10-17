#! /bin/zsh

# Setup X410 X11 forwarding
export DISPLAY=:5.0
if [ ! -e /tmp/.X11-unix/X5 ] ; then
    socat -b65536 UNIX-LISTEN:/tmp/.X11-unix/X5,fork,mode=777 SOCKET-CONNECT:40:0:x0000x70170000x02000000x00000000 &
fi

