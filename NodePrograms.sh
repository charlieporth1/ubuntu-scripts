#!/bin/bash
echo "killing node"
sudo killall  node
echo "success"
sleep 5
echo "starting node"
sudo nohup node /mnt/HDD/itunes-connect-slack/poll-itc.js  & > /dev/null
#cd /mnt/HDD/itunes-connect-slack && sudo node poll-itc.js &
cd /mnt/HDD/SLACK/2fa-2-slack/ && nohup npm start & > /dev/null
sudo nohup node /mnt/HDD/SLACK/2fa-2-slack/app.js  & > /dev/null
sudo nohup node /mnt/HDD/SLACK/AppReviewSlack/server.js & > /dev/null
sudo nohup node /var/www/SMSLinkRECIVED.js  & > /dev/null
sudo nohup node /mnt/HDD/itunes-connect-slack/poll-itc.js  & > /dev/null
#echo "starting without nohup"
#sudo node /mnt/HDD/itunes-connect-slack/poll-itc.js  & > /dev/null
#cd /mnt/HDD/itunes-connect-slack && sudo node poll-itc.js &
#cd /mnt/HDD/SLACK/2fa-2-slack/ && npm start & > /dev/null
#sudo node /mnt/HDD/SLACK/2fa-2-slack/app.js  & > /dev/null
#sudo node /mnt/HDD/SLACK/AppReviewSlack/server.js & > /dev/null
#sudo node  /var/www/SMSLinkRECIVED.js  & > /dev/null
echo "success"
