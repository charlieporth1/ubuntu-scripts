#Bahs
hdd=/mnt/HDD
prog=/mnt/HDD/Programs
master=${2:-$(hostname)}
root="root"

if [[ "$(hostname)" == "$master" ]]; then
        for host in $(grep -iv $master "${HOME}/.parallel/sshloginfile" | grep -iv root); do
            # Recurse to connect to master node; -t required for passwords.
            # source ~/.profile required to get this script in $PATH.
		ssh $host mkdir ~/Programs/
		scp $hdd/cockpit/updatecock.sh $host:~/Programs/ 
		scp $prog/update-fix.sh $host:~/Programs/
		scp $prog/update.sh $host:~/Programs/
		scp $prog/weather.sh $host:~/Programs/
		scp $prog/killMemoryHogs.sh $host:~/Programs/
		scp $prog/lines.sh $host:~/Programs/
		scp $prog/Cleanup.sh $host:~/Programs/
		scp $prog/email-virus-report.sh $host:~/Programs/
		#scp $prog/install-new-server.sh $host:~/Programs/
		scp $prog/server/installnewserver.sh $host:~/Programs/
		#scp $prog/server/install-new-server.sh $host:~/Programs/
		scp $prog/Cleanup.sh $host:~/Programs/
		scp $prog/server/* $host:~/Programs/
		scp $prog/jaildefaultunban.sh  $host:~/Programs
		scp $prog/filesystemparallel.sh  $host:~/
		scp $prog/filesystemparallel.sh  $host:~/Programs
		scp /opt/*.sh $host:~/Programs/
		scp /opt/*.sh $host:/opt/
		scp /usr/sbin/cred.x $host:~/Programs/
		scp /usr/bin/cred.sh $host:~/Programs/
		scp /usr/bin/cred.sh $host:/usr/bin/
		scp $prog/server/sshbannersetup.sh $host:~/Programs/
	echo "done connecting to USER $host" | grep -i $host
	done
	for host in $(grep -iv $master "${HOME}/.parallel/sshloginfile" | grep -i root); do

		scp /usr/bin/cred.sh $host:/usr/bin/
		scp /usr/sbin/cred.sh $host:/usr/sbin/
		scp /opt/*.sh $host:/opt
		ssh $host chmod a+x /opt/*.sh
		scp $prog/server/rc.local  $host:/etc/rc.local
		ssh $host chmod a+x /etc/rc.local
		ssh $host bash /home/*/Programs/sshbannersetup.sh
		ssh $host bash /home/*/Programs/installnewserver.sh 

	echo "done with ROOT $host" | grep -i $host
	done
echo "all done"
fi

