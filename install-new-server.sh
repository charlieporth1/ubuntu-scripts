master=${2:-$(hostname)}
hdd=/mnt/HDD/
prog=/mnt/HDD/Programs
cp -rf /opt/*.sh $prog/
    if [[ "$(hostname)" == "$master" ]]; then
        for host in $(grep -v $master "${HOME}/.parallel/sshloginfile"); do
            # Recurse to connect to master node; -t required for passwords.
            # source ~/.profile required to get this script in $PATH.
sudo scp $prog/lines.sh $host:~/Programs
sudo scp $prog/server/* $host:~/Programs
sudo scp $prog/Cleanup.sh $host:~/Programs
sudo scp $prog/weather.sh $host:~/Programs
sudo scp $prog/filesystemparallel.sh  $host:~/Programs
sudo scp $prog/update.sh $host:~/Programs
sudo scp $prog/update-fix.sh $host:~/Programs
sudo scp /opt/*.sh $host:/opt
sudo scp /opt/*.sh $host:~/Programs


        echo done connecting to $host
        done
fi
