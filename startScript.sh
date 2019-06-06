#!/bin/bash
#this script is because you cannot cd in /etc/rc.local to another dir without breaking that machine


sudo node /mnt/HDD/itunes-connect-slack/poll-itc.js  &
node /mnt/HDD/SLACK/2fa-2-slack/app.js &
cd /mnt/HDD/itunes-connect-slack/
sudo node poll-itc.js  &
cd /mnt/HDD/SLACK/2fa-2-slack/
npm start &

disown -a && exit 0
