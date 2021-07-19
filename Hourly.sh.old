#!/usr/bin/parallel --shebang-wrap --pipe /bin/bash
#hourl
#this causes it to fail
#sudo su
#curl -fsS --retry 3 https://hc-ping.com/f0465043-4644-4a32-8e60-f2d0292bce9d
#ps -aux | grep 'pm.stal\|test_' | awk '{print $2}' | xargs sudo kill -9 && sudo killall awk ps grep pgrep

ps -aux | grep 'pm.stal\|test_\|pm.hea\|set_fail2ban\|health' | grep -v 'grep' | awk '{print $2}' | xargs sudo kill -9
sudo killall ps dig go pgrep awk grep

source /mnt/HDD/Programs//memoryClean.sh
sudo ufw disable
sudo bash /mnt/HDD/Programs/killMemoryHogs.sh
sleep 5s
#sudo bash /mnt/HDD/Programs/DDNSUPDATE.sh
sudo bash /mnt/HDD/Programs/DDNSUPDATE1.sh
sudo bash /mnt/HDD/Programs/DDNSUPDATE1ctp.sh
sudo bash /opt/serveripchange.sh

sudo cp -rf /home/ubuntuserver/.ssh/* /root/.ssh/
sudo cp -rf /home/ubuntuserver/.parallel/* /root/.parallel/
sudo cp -rf /home/ubuntuserver/.fastlane/* /root/.fastlane/
sudo cp -rf /home/ubuntuserver/.config/* /root/.config/
sudo cp -rf /home/ubuntuserver/.git* /root/.git*
sudo cp -rf /home/ubuntuserver/.netrc /root/
sudo rm -rf /tmp/*

#sudo bash /mnt/HDD/Programs/NodePrograms.sh
#sudo bash /mnt/HDD/Programs//iTunesConnecBuildProcessingDone.sh

sudo bash /mnt/HDD/Programs//jaildefaultunban.sh &

#journalctl --flush
#journalctl --rotate
#journalctl --vacuum-size=20M
#journalctl --vacuum-time=1d


#sudo node /mnt/HDD/itunes-connect-slack/poll-itc.js

#Clear RAM
cleanMemory
#sudo service gitlab stop
##Start Cockpit

#Time Delay #1 Start Cockpit
#sudo timeout 10 "sudo systemctl start cockpit.socket"


sudo cp -rf /opt/*.sh  /mnt/HDD/Programs/

#start backup
#sudo zip -r9 /mnt/HDD/Backup/Website/Hourly/www.zip /var/www/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*
#sudo node /mnt/HDD/SLACK/ReviewMe/index.js  

cleanMemory

#update ip
#sudo /mnt/HDD/minio server /mnt/HDD    

#cd /mnt/HDD/workspace/google-rank-finder
#sudo bash notify.sh &
#sudo bash /mnt/HDD/Programs/newKernelCustomModprobes.sh
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
#sudo bash /mnt/HDD/Programs/Bots.sh #| parallel -Jcluster &
#cd /mnt/HDD/workspace/GET_FOLLOWERS/twitter-bot-for-increased-growth 
#timeout 300 
#timeout 3600 python app.py  & 2>&1 /dev/shm/twitterBot
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
cleanMemory

#sudo bash /mnt/HDD/Programs/cleanSysLog.sh
#sudo bash /mnt/HDD/Programs/rotate-clean-Logs.sh

#sudo killall hans
#sudo node /var/www/SMSLinkRECIVED.js &
#cpulimit -l 30 hans -s 192.168.1.250 -p TheFutureIsUS99#hans=
curl -fsS --retry 3 https://hc-ping.com/09bb4e77-b7aa-4aaf-bd64-3f444f29d3ae
#disown -a
#&& exit 0
