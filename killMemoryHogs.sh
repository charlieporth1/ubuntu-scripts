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
debugg=true
declare -a programs=('mysqld' 'docker-containerd' 'htop' 'postgress' 'snapd' 'perl' 'ruby2.5' 'ruby') #'chromedriver') #W'fail2ban')
function log() {
        if [[ $debugg == true ]]; then
                    echo "Log message: $1" >&2
	fi
} 
#for ((k=0; i < ${#programs[@]}; k++)); do 
for program in $(echo ${programs[@]})
do
	echo "program: $program"
	sudo killall -9 $program  #${programs[$k]}
	sudo killall -8 $program  #${programs[$k]}
	sudo killall -7 $program  #${programs[$k]}
	sudo killall -6 $program  #${programs[$k]}
	sudo killall -5 $program  #${programs[$k]}
	sudo killall -4 $program  #${programs[$k]}
	sudo killall -3 $program  #${programs[$k]}
	sudo killall -2 $program  #${programs[$k]}
	sudo killall -1 $program  #${programs[$k]}
	sudo killall $program  #${programs[$k]}
done

sleep 3s
for program in $(echo ${programs[@]})
do
	echo "program: $program"
	for process in  `pgrep $program`
	do
	kill -9 $process 
	kill -8 $process 
	kill -7 $process 
	kill -6 $process 
	kill -5 $process 
	kill -4 $process 
	kill -3 $process 
	kill -2 $process 
	kill -1 $process 
	kill -0 $process 
	kill $process 
	echo "killed $process"
	done
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
