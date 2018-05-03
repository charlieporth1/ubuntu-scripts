master=${2:-$(hostname)}
hdd=/mnt/HDD/
prog=/mnt/HDD/Programs

    if [[ "$(hostname)" == "$master" ]]; then
        for host in $(grep -v $master "${HOME}/.parallel/sshloginfile"); do
            # Recurse to connect to master node; -t required for passwords.
            # source ~/.profile required to get this script in $PATH.
scp $prog/lines.sh $host:~/Programs
scp $prog/server/* $host:~/Programs
scp $prog/Cleanup.sh $host:~/Programs
scp $prog/weather.sh $host:~/Programs
scp $prog/filesystemparallel.sh  $host:~/Programs
scp $prog/update.sh $host:~/Programs
scp $prog/update-fix.sh $host:~/Programs


        echo done connecting to $host
        done
fi
