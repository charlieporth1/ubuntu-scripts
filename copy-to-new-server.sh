#Bahs
hdd=/mnt/HDD
prog=/mnt/HDD/Programs
master=${2:-$(hostname)}

if [[ "$(hostname)" == "$master" ]]; then
        for host in $(grep -v $master "${HOME}/.parallel/sshloginfile"); do
            # Recurse to connect to master node; -t required for passwords.
            # source ~/.profile required to get this script in $PATH.
scp $hdd/cockpit/updatecock.sh $host:~/Programs/ 
scp $prog/update-fix.sh $host:~/Programs/
scp $prog/update.sh $host:~/Programs/
scp $prog/weather.sh $host:~/Programs/
scp $prog/killMemoryHogs.sh $host:~/Programs/
scp $prog/lines.sh $host:~/Programs/
scp $prog/Cleanup.sh $host:~/Programs/
scp $prog/email-virus-report.sh $host:~/Programs/
scp $prog/install-new-server.sh $host:~/Programs/
scp $prog/Cleanup.sh $host:~/Programs/
scp $prog/server/* $host:~/Programs/
scp $prog/jaildefaultunban.sh  $host:~/Programs
scp /opt/*.sh $host:~/Programs/
scp /usr/sbin/cred.x $host:~/Programs/

        echo done connecting to $host
        done
fi

