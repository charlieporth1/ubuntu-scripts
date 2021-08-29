#!/bin/bash

#sudo cgexec -g cpu:fourthcpulimied -g memory:512MBRam --sticky `which fail2ban-server`
#sudo cgexec -g cpu:fourthcpulimied -g memory:256MBRam --sticky `which tailscale`

if ps -aux | grep -v 'grep' | grep dockerd &> /dev/null
then
        sudo cgexec -g cpu:fourthcpulimied -g memory:512MBRam --sticky /usr/bin/dockerd
fi

if [[ -f $PROG/custom-program_usage_retrictions.sh ]]; then
	bash $PROG/custom-program_usage_retrictions.sh
elif [[ -f $PROG/$HOSTNAME-program_usage_retrictions.sh ]]; then
	bash $PROG/$HOSTNAME-program_usage_retrictions.sh
fi
