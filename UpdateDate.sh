hdd=/mnt/HDD
prog=/mnt/HDD/Programs
master=${2:-$(hostname)}

if [[ "$(hostname)" == "$master" ]]; then
        for host in $(grep -v $master "${HOME}/.parallel/sshloginfile"); do
            # Recurse to connect to master node; -t required for passwords.
            # source ~/.profile required to get this script in $PATH.

date --set="$(ssh $host date)"
        echo done connecting to $host
        done
fi


