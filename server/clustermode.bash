#!/bin/bash

# clustermode.bash:
# Set up a shared sshfs file system in the same path (relative to $HOME)

set -ue

usage_message="Usage: clustermode.bash <up|down>"

# If script is called without specifying a master node, assume it's us.
master=${2:-$(hostname)}
sharedir="${HOME}/sshfs/${master}"

up ()
{
    # Ensure mountpoint exists.
    [ -d "$sharedir" ] || mkdir -p "$sharedir"
    # Mount shared fs; nohup required to avoid immediate unmount.
    nohup sshfs \
       -o Cipher=arcfour256 \
       -o follow_symlinks \
       "${master}:" "$sharedir" \
       >/dev/null
echo done with sshfs 
    # If we are the master node:
    if [[ "$(hostname)" == "$master" ]]; then
        for host in $(grep -v $master "${HOME}/.parallel/sshloginfile"); do
            # Recurse to connect to master node; -t required for passwords.
            # source ~/.profile required to get this script in $PATH.
            ssh -t $host "source ~/.profile; clustermode.bash up ${master}" \
                || echo "$host unreachable"
	echo done connecting to $host
        done
        # Switch to current path in the shared filesystem.
        wd=$(pwd)
        cd "${sharedir}/${wd#${HOME}}"
        exec "$SHELL"
    fi
}

down ()
{
    fusermount -u "$sharedir"
    if [[ "$(hostname)" == "$master" ]]; then
        for host in $(grep -v $master "${HOME}/.parallel/sshloginfile"); do
            ssh -t $host "source ~/.profile; clustermode.bash down ${master}" \
                || echo "Could not deactivate ${host}."
        done
    fi
}


if [[ $# -eq 0 ]];then
    echo "$usage_message"
    exit 1
fi

if [[ "$1" == "up" ]]; then
    up
elif [[ "$1" == "down" ]]; then
    down
else
    echo "$usage_message"
fi
