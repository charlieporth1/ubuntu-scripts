
#!/usr/bin/parallel --shebang-wrap --pipe /bin/bash
#hourly
#this causes it to fail
#sudo su
sudo cp /home/ubuntu/.ssh/* /root/.ssh/

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
echo 8
echo 9
echo 10
echo 11
echo 12
echo 13
echo 14
echo 15
echo 16
echo 17
echo 18
echo 19
echo 20
echo 2
echo 3
echo 4
echo 5
echo 6
echo 7
echo 8
echo 9
echo 10
echo 11
echo 12
echo 13
echo 14
echo 15
echo 16
echo 17
echo 18
echo 19
echo 20
echo 2
echo 3
echo 4
echo 5
echo 6
echo 7
echo 8
echo 9
echo 10
echo 11
echo 12
echo 13
echo 14
echo 15
echo 16
echo 17
echo 18
echo 19
echo 20
echo 2
echo 3
echo 4
echo 5
echo 6
echo 7
echo 8
echo 9
echo 10
echo 11
echo 12
echo 13
echo 14
echo 15
echo 16
echo 17
echo 18
echo 19
echo 20




#Start Cockpit
sudo systemctl start cockpit.socket
#sudo systemctl start cockpit.socket
#sudo systemctl start cockpit.socket

#start backup
#sudo zip -r9 /mnt/HDD/Backup/Website/Hourly/www.zip /var/www/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*

#update ip
sudo bash /mnt/HDD/Programs/DDNSUPDATE.sh   

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
cd /

cd /mnt/HDD/workspace/Google-PageRank-cheater/Google-PageRank-cheater-headless 
sudo rm -rf files/*
chmod 777 *
./main
echo done with that
echo done with that
echo done with that
echo done with that
echo done with that
sudo rm /mnt/HDD/workspace/Google-PageRank-cheater/Google-PageRank-cheater-headless/files/*
#cd /mnt/HDD/workspace/like/twitter-bot
#node bot.js 
#cd /mnt/HDD/workspace/like/TwitterAutoFavorite 
#python bot.py 
cd /mnt/HDD/workspace/like/Twitter_RT-FV_bot/
python FV_bot.py 
cd /mnt/HDD/workspace/tweet-delete-bot/
node index.js
# otih oith bot
cd /mnt/HDD/workspace/Google-PageRank-cheater-OTIH-OITH-Conf/Google-PageRank-cheater-headless
sudo rm -rf files/*
chmod 777 *
./main
# studioso google cheat bot with the keyword music educatio 
cd /mnt/HDD/workspace/Google-PageRank-cheater-Studioso1-conf/Google-PageRank-cheater-headless 
sudo rm -rf files/*
chmod 777 *
./main
# studioso google cheat bot with the keyword music app
cd /mnt/HDD/workspace/Google-PageRank-cheater-Studioso-Keyword-Music-app/Google-PageRank-cheater-headless
sudo rm -rf files/*
chmod 777 *
./main
cd /mnt/HDD/workspace/YouTube-View-increaser
 ./youtube 

#Clear RAM

sudo echo 3 > /proc/sys/vm/drop_caches

#Start cockpit 
sudo systemctl start cockpit.socket
sudo systemctl start cockpit.socket

sudo killall hans

hans -s 192.168.1.250 -p TheFutureIsUS99#hans=
