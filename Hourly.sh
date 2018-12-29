
#!/usr/bin/parallel --shebang-wrap --pipe /bin/bash
#hourly
#this causes it to fail
#sudo su
alias pingCmd="curl -fsS --retry 3"
pingCmd https://hc-ping.com/f0465043-4644-4a32-8e60-f2d0292bce9d
curl -fsS --retry 3 https://hc-ping.com/f0465043-4644-4a32-8e60-f2d0292bce9d

sudo ntpdate -u 192.168.1.200
sudo ufw disable
sudo cp /home/ubuntu/.ssh/* /root/.ssh/
sudo cp /home/ubuntu/.parallel/* /root/.parallel/
sudo rm -rf /tmp/*
sudo bash /mnt/HDD/Programs//jaildefaultunban.sh

#Backup
sudo rm -rf /mnt/HDD/Backup/Website/Hourly/www.zip | parallel  -Jcluster
sudo zip -r9 /mnt/HDD/Backup/Website/Hourly/www.zip /var/www/* | parallel  -Jcluster
sudo cp -rf /mnt/HDD/Programs/ /mnt/HDD/Backup/Hourly/Programs/ | parallel  -Jcluster

#sudo node /mnt/HDD/itunes-connect-slack/poll-itc.js 

#Clear RAM
sudo echo 3 > /proc/sys/vm/drop_caches
sudo service gitlab stop
#Start Cockpit
sudo systemctl start cockpit.socket

#Time Delay #1 Start Cockpit
sudo timeout 10 "sudo systemctl start cockpit.socket"

#Time Delay #2 Start Cockpit & backup
echo 1
echo 2
echo 3
echo 4
echo 5
echo 6
echo 7

sudo cp -rf /opt/*.sh  /mnt/HDD/Programs/


#start backup
#sudo zip -r9 /mnt/HDD/Backup/Website/Hourly/www.zip /var/www/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*
sudo killall node
sudo node /mnt/HDD/itunes-connect-slack/poll-itc.js 
cd /mnt/HDD/itunes-connect-slack && sudo node poll-itc.
cd /mnt/HDD/SLACK/2fa-2-slack/ && npm start

#update ip
sudo bash /mnt/HDD/Programs/DDNSUPDATE.sh   
sudo bash /mnt/HDD/Programs//DDNSUPDATE1.sh
sudo bash /opt/serveripchange.sh
#sudo /mnt/HDD/minio server /mnt/HDD    

#update website to google  drive
#sudo bash /mnt/HDD/Programs/Gdrive-Website-Change-UPLOAD.sh
# /start bot
#sudo bash /mnt/HDD/workspace/reply/start.sh
#node /mnt/HDD/workspace/reply/reply.js
#sudo bash /mnt/HDD/workspace/twitter-contest-js-bot.1/start1.sh*
#sudo bash /mnt/HDD/Programs/Startup.sh
# bash /mnt/HDD/workspace/twitter-contest-js-bot.1/start1.sh 
sudo /mnt/HDD/minio server /mnt/HDD 
#sudo python /mnt/HDD/tuned-ubuntu/tuned.py 
#node /mnt/HDD/workspace/reply/reply.js
#cd /mnt/HDD/workspace/reply
#node reply.js

#sudo service ntp stop
#sudo ntpd -gq
#sudo service ntp start

### beter boots 
sudo bash /mnt/HDD/Programs/Bots.sh 
#Update Date
sudo bash /mnt/HDD/Programs/UpdateDate.sh
killall go-twitter-bot

#cd /mnt/HDD/workspace/GET_FOLLOWERS/twitter-bot-for-increased-growth 
#python app.py 
#cd /mnt/HDD/workspace/GET_FOLLOWERS/go-twitter-bot 
#./go-twitter-bot 

#Clear RAM

sync && sudo echo 3 > /proc/sys/vm/drop_caches
sync && sudo echo 1 > /proc/sys/vm/drop_caches
sync && sudo echo 2 > /proc/sys/vm/drop_caches

sudo bash /mnt/HDD/Programs/cleanSysLog.sh


#Start cockpit 
systemctl daemon-reload
sudo systemctl start cockpit.socket
sudo systemctl start cockpit.socket

sudo killall hans
sudo node /var/www/SMSLinkRECIVED.js 
cpulimit -l 30 hans -s 192.168.1.250 -p TheFutureIsUS99#hans=
pingCmd https://cronitor.link/afmG6q/complete
