
#!/usr/bin/parallel --shebang-wrap --pipe /bin/bash
#hourly
#this causes it to fail
#sudo su
sudo cp /home/ubuntu/.ssh/* /root/.ssh/
sudo cp /home/ubuntu/.parallel/* /root/.parallel/
sudo rm -rf /tmp/*
sudo bash /mnt/HDD/Programs//jaildefaultunban.sh

#Backup
sudo rm -rf //mnt/HDD/Backup/Website/Hourly/www.zip | parallel -j128 -Jcluster
sudo zip -r9 /mnt/HDD/Backup/Website/Hourly/www.zip /var/www/* | parallel -j128 -Jcluster
sudo cp -rf /mnt/HDD/Programs/ /mnt/HDD/Backup/Hourly/Programs/ | parallel -j128 -Jcluster

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




#start backup
#sudo zip -r9 /mnt/HDD/Backup/Website/Hourly/www.zip /var/www/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*

#update ip
sudo bash /mnt/HDD/Programs/DDNSUPDATE.sh   
sudo bash /mnt/HDD/Programs//DDNSUPDATE1.sh
sudo /mnt/HDD/minio server /mnt/HDD    

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

sudo service ntp stop
sudo ntpd -gq
sudo service ntp start

### beter boots 
sudo bash /mnt/HDD/Programs/Bots.sh 
#Update Date
sudo bash /mnt/HDD/Programs/UpdateDate.sh
killall go-twitter-bot

cd /mnt/HDD/workspace/GET_FOLLOWERS/twitter-bot-for-increased-growth 
python app.py 
#cd /mnt/HDD/workspace/GET_FOLLOWERS/go-twitter-bot 
#./go-twitter-bot 

#Clear RAM

sync && sudo echo 3 > /proc/sys/vm/drop_caches
sync && sudo echo 1 > /proc/sys/vm/drop_caches
sync && sudo echo 2 > /proc/sys/vm/drop_caches

#Start cockpit 
systemctl daemon-reload
sudo systemctl start cockpit.socket
sudo systemctl start cockpit.socket

sudo killall hans

cpulimit -l 30 hans -s 192.168.1.250 -p TheFutureIsUS99#hans=
