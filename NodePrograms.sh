#!/bin/bash
echo "killing node"
sudo killall  node
echo "success"
sleep 5
echo "starting node"
#function startNode() {
	hup=false
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
	sudo $out node /mnt/HDD/itunes-connect-slack/poll-itc.js > /dev/null 2>&1 &
	#cd /mnt/HDD/itunes-connect-slack && sudo node poll-itc.js &
	cd /mnt/HDD/SLACK/2fa-2-slack/ && $out npm start  > /dev/null 2>&1 &
	sudo $out node /mnt/HDD/SLACK/2fa-2-slack/app.js > /dev/null 2>&1 &
	sudo $out node /mnt/HDD/SLACK/AppReviewSlack/server.js > /dev/null 2>&1 &
	sudo $out node /var/www/SMSLinkRECIVED.js > /dev/null 2>&1 &
	sudo $out node /mnt/HDD/itunes-connect-slack/poll-itc.js > /dev/null 2>&1 &
	echo "success"
#return
#}
#startNode
