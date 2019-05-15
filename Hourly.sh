#!/usr/bin/parallel --shebang-wrap --pipe /bin/bash
#hourl
#this causes it to fail
#sudo su
curl -fsS --retry 3 https://hc-ping.com/f0465043-4644-4a32-8e60-f2d0292bce9d

sudo /etc/init.d/ntp stop
sudo ntpd -q 192.168.1.200 
ntpdate -u 192.168.1.200
sudo /etc/init.d/ntp start
sudo ufw disable

sudo bash /mnt/HDD/Programs/DDNSUPDATE.sh   
sudo bash /mnt/HDD/Programs//DDNSUPDATE1.sh
sudo bash /mnt/HDD/Programs//DDNSUPDATE1ctp.sh
sudo bash /opt/serveripchange.sh

sudo cp -rf /home/ubuntuserver/.ssh/* /root/.ssh/
sudo cp -rf /home/ubuntuserver/.parallel/* /root/.parallel/
sudo cp -rf /home/ubuntuserver/.config/* /root/.config/
sudo rm -rf /tmp/*

sudo bash /mnt/HDD/Programs//jaildefaultunban.sh &

journalctl --flush
journalctl --rotate
journalctl --vacuum-size=20M
journalctl --vacuum-time=1d

#Backup
sudo rm -rf /mnt/HDD/Backup/Website/Hourly/www.zip | parallel  -Jcluster
sudo zip -r9 /mnt/HDD/Backup/Website/Hourly/www.zip /var/www/ | parallel  -Jcluster
sudo cp -rf /mnt/HDD/Programs/ /mnt/HDD/Backup/Hourly/Programs/ | parallel  -Jcluster

#sudo node /mnt/HDD/itunes-connect-slack/poll-itc.js 

#Clear RAM
sudo echo 3 > /proc/sys/vm/drop_caches
sudo echo 2 > /proc/sys/vm/drop_caches
sudo echo 1 > /proc/sys/vm/drop_caches
#sudo service gitlab stop
##Start Cockpit
sudo systemctl start cockpit.socket

#Time Delay #1 Start Cockpit
#sudo timeout 10 "sudo systemctl start cockpit.socket"

#Time Delay #2 Start Cockpit & backup
echo 1
echo 2
echo 3
echo 4
echo 5
echo 6
echo 7

sudo cp -rf /opt/*.sh  /mnt/HDD/Programs/
sudo bash /mnt/HDD/Programs/killMemoryHogs.sh

#start backup
#sudo zip -r9 /mnt/HDD/Backup/Website/Hourly/www.zip /var/www/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*
sudo bash /mnt/HDD/Programs//NodePrograms.sh 
#sudo node /mnt/HDD/SLACK/ReviewMe/index.js  

sudo echo 3 > /proc/sys/vm/drop_caches
sudo echo 2 > /proc/sys/vm/drop_caches
sudo echo 1 > /proc/sys/vm/drop_caches

#update ip
#sudo /mnt/HDD/minio server /mnt/HDD    

cd /mnt/HDD/workspace/google-rank-finder
sudo bash notify.sh &
sudo bash /mnt/HDD/Programs/newKernelCustomModprobes.sh
#update website to google  drive
#sudo bash /mnt/HDD/Programs/Gdrive-Website-Change-UPLOAD.sh
# /start bot
#sudo bash /mnt/HDD/workspace/reply/start.sh
#node /mnt/HDD/workspace/reply/reply.js
#sudo bash /mnt/HDD/workspace/twitter-contest-js-bot.1/start1.sh*
#sudo bash /mnt/HDD/Programs/Startup.sh
# bash /mnt/HDD/workspace/twitter-contest-js-bot.1/start1.sh 
#sudo /mnt/HDD/minio server /mnt/HDD & 
#sudo python /mnt/HDD/tuned-ubuntuserver/tuned.py 
#node /mnt/HDD/workspace/reply/reply.js
#cd /mnt/HDD/workspace/reply
#node reply.js

#sudo service ntp stop
#sudo ntpd -gq
#sudo service ntp start

### beter boots 
sudo bash /mnt/HDD/Programs/Bots.sh #| parallel -Jcluster &
#sudo echo 3 > /proc/sys/vm/drop_caches
#sudo echo 2 > /proc/sys/vm/drop_caches
#sudo echo 1 > /proc/sys/vm/drop_caches
#Update Date
#sudo bash /mnt/HDD/Programs/UpdateDate.sh

#cd /mnt/HDD/workspace/GET_FOLLOWERS/twitter-bot-for-increased-growth 
#python app.py 
#cd /mnt/HDD/workspace/GET_FOLLOWERS/go-twitter-bot 
#./go-twitter-bot 

#Clear RAM

sync && sudo echo 3 > /proc/sys/vm/drop_caches
sync && sudo echo 1 > /proc/sys/vm/drop_caches
sync && sudo echo 2 > /proc/sys/vm/drop_caches

sudo bash /mnt/HDD/Programs/cleanSysLog.sh
sudo bash /mnt/HDD/Programs/cleanSysLog.sh 
sudo bash /mnt/HDD/Programs/rotate-clean-Logs.sh 
#Start cockpit 
systemctl daemon-reload
sudo systemctl start cockpit.socket

#sudo killall hans
#sudo node /var/www/SMSLinkRECIVED.js &
#cpulimit -l 30 hans -s 192.168.1.250 -p TheFutureIsUS99#hans=
curl -fsS --retry 3 https://hc-ping.com/09bb4e77-b7aa-4aaf-bd64-3f444f29d3ae
disown -a && exit 0
