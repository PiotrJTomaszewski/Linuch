# Execute if connected by SSH
if [ -n $SSH_CONNECTION ] ; then
    if [ -e ~/Scripts/on_ssh_login.sh ] ; then
        source ~/Scripts/on_ssh_login.sh
    fi
fi

