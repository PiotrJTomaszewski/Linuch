#! /bin/zsh

# Setup X410 X11 forwarding
export DISPLAY=:5.0
if [ ! -e /tmp/.X11-unix/X5 ] ; then
    socat -b65536 UNIX-LISTEN:/tmp/.X11-unix/X5,fork,mode=777 SOCKET-CONNECT:40:0:x0000x70170000x02000000x00000000 &
fi

# Fix GTK applications waiting 25 seconds to start
if [ `ps -ux | grep dbus-daemon | wc -l` -eq 1 ];  then # If current user doesn't have dbus running (one result will be our grep)
    dbus_params=`dbus-launch`
    echo '' > /dev/shm/dbus_env.sh
    while IFS= read -r line; do
        echo "export $line" >> /dev/shm/dbus_env.sh
    done <<< "$dbus_params"
fi

