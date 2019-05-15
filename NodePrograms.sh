#!/bin/bash
echo "killing node"
sudo killall  node
echo "success"
sleep 5
echo "starting node"
hup=true
bkg=true
node=false
#	redirect=/dev/null 2>&1 &
redirect=/bin/cat > /dev/null 2>&1 &
sleep 1s
if [[ $bkg == true ]];then
	bg=\&
else
	bg=
fi
if [[ $hup == true ]]; then
	out=nohup
else
	out=
fi
	#if [[ $node == true ]]; then
	#	prog=node
	#else 
		#prog=forever -o /dev/null
	#fi
sleep 1s
rm -rf /dev/shm/*
#sudo $out node /mnt/HDD/itunes-connect-slack/poll-itc.js > /dev/null 2>&1 &!
#sudo $out node /mnt/HDD/itunes-connect-slack/poll-itc.js > /tmp/itcnode   2>&1  &!
sudo $out node /mnt/HDD/itunes-connect-slack/poll-itc.js > /dev/shm/itcnode   2>&1  &!
echo "itc slack done" 
#sudo forever -o /dev/null  /mnt/HDD/itunes-connect-slack/poll-itc.js > /dev/null 2>&1 &!
#cd /mnt/HDD/itunes-connect-slack && sudo node poll-itc.js &
#cd /mnt/HDD/SLACK/2fa-2-slack/ && $out npm start > /dev/shm/2fator 2>&1 &!
sudo $out node /mnt/HDD/SLACK/2fa-2-slack/app.js > /dev/shm/2factor 2>&1 &!
sudo $out node /mnt/HDD/SLACK/AppReviewSlack/server.js > /dev/shm/appReview  2>&1 &!
sudo $out node /var/www/SMSLinkRECIVED.js > /dev/shm/SMS 2>&1 &!
echo "success"
disown -a && exit 0

