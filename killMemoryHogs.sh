#!/bin/bash
#sudo killall docker-containerd 
#sudo killall mysqld
#sudo killall perl
#sudo killall bash
#sudo killall sudo
#sudo killall postgres
#sudo killall dockerd
#sudo killall snapd
#sudo killall htop
#sudo killall -s SIGKILL perl
declare -a programs
programs=('mysqld' 'docker-containerd' 'htop' 'postgress' 'snapd' 'perl'} #W'fail2ban')

for ((k=0; i <= ${#programs[@]}; k++)); do 
sudo killall -s SIGKILL ${programs[$k]}
sudo killall -9 ${programs[$k]}
sudo killall -8 ${programs[$k]}
sudo killall -7 ${programs[$k]}
sudo killall -6 ${programs[$k]}
sudo killall -5 ${programs[$k]}
sudo killall -4 ${programs[$k]}
sudo killall -3 ${programs[$k]}
sudo killall -2 ${programs[$k]}
sudo killall -1 ${programs[$k]}
sudo killall -0 ${programs[$k]}
done
#declare -a tooManySSH
#tooManySSH=(`ps -u root | grep -iv sshd  | grep -i ssh  |   awk '{print $1}'`)
sync; echo 1 > /proc/sys/vm/drop_caches
sync; echo 2 > /proc/sys/vm/drop_caches
sync; echo 3 > /proc/sys/vm/drop_caches

#sudo rm -rf /var/run/fail2ban/fail2ban.sock 
#cpulimit -l 15 -- fail2ban-server
#for (( i = 0 ; i < ${#tooManySSH[@]} ; i++))
#do
#echo "On $i"
#echo "Total ${#tooManySSH[@]} "
#sudo kill -l 9  "${tooManySSH[$i]}"
#done
