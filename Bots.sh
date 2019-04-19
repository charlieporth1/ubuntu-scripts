#!/usr/bin/parallel --shebang-wrap -j+64 --pipe /bin/bash
#!/bin/bash
#Better Bots for pageraking and youtubeVieing
#they have random time delays 
#Youtube charlieporth
#15min
curl -fsS --retry 3 https://hc-ping.com/906c2e51-893d-42bb-9915-16cecdb4f873 
#firefox --headless &
sudo /etc/init.d/tor start
headless=true #this is the headless bot not browser 
export rootDir=/mnt/HDD/workspace
if [ $headless ]; then
export dir=Google-PageRank-cheater-headless/
export cmd=./main
else
export dir=Google-PageRank-cheater-browser-aided/
export cmd=./google
fi 
cd $rootDir/YouTube-View-increaser
#timeout $((1 + RANDOM % 900 )) ./youtube 
#./youtube 
sudo echo 3 > /proc/sys/vm/drop_caches
sudo echo 2 > /proc/sys/vm/drop_caches
sudo echo 1 > /proc/sys/vm/drop_caches
#Studioso music app keyword
cd $rootDir/Google-PageRank-cheater-Studioso-Keyword-Music-app/$dir/
sudo rm -rf files/*
##5min
#cpulimit -l 30 $cmd
$cmd   #| parallel -Jcluster 
#timeout $((60 + RANDOM % 300 ))  $cmd
sudo echo 3 > /proc/sys/vm/drop_caches
sudo echo 2 > /proc/sys/vm/drop_caches
sudo echo 1 > /proc/sys/vm/drop_caches
# studioso google cheat bot with the keyword music educatio 
cd $rootDir/Google-PageRank-cheater-Studioso1-conf/$dir 
sudo rm -rf files/*

#600 seconds == ten min
#timeout $((55 + RANDOM % 600 )) $cmd
#cpulimit -l 30 $cmd
$cmd  #| parallel -Jcluster 
sudo echo 3 > /proc/sys/vm/drop_caches
sudo echo 2 > /proc/sys/vm/drop_caches
sudo echo 1 > /proc/sys/vm/drop_caches
# otih oith bot
cd $rootDir/Google-PageRank-cheater-OTIH-OITH-Conf/$dir
sudo rm -rf files/*

#3min
#timeout $((55 + RANDOM % 180 ))  $cmd
#cpulimit -l 30 $cmd
$cmd #| parallel -Jcluster 
sudo echo 3 > /proc/sys/vm/drop_caches
sudo echo 2 > /proc/sys/vm/drop_caches
sudo echo 1 > /proc/sys/vm/drop_caches
cd $rootDir/Google-PageRank-cheater/$dir 
sudo rm -rf files/*

$cmd 
#timeout $((1 + RANDOM % 180 )) $cmd
echo done with that
echo done with that
echo done with that
echo done with that
echo done with that
sudo echo 3 > /proc/sys/vm/drop_caches
sudo echo 2 > /proc/sys/vm/drop_caches
sudo echo 1 > /proc/sys/vm/drop_caches
#apps_for_music_teacher
cd $rootDir/Google-PageRank-cheater-apps_for_music_teachers/$dir/
sudo rm -rf files/*   

#timeout $((15 + RANDOM % 180 ))  $cmd
#cpulimit -l 30 $cmd
sudo echo 3 > /proc/sys/vm/drop_caches
sudo echo 2 > /proc/sys/vm/drop_caches
sudo echo 1 > /proc/sys/vm/drop_caches
 $cmd #| parallel -Jcluster 
cd $rootDir/Google-PageRank-cheater-apps_for_teachers_to_track_student_progress/$dir/
sudo rm -rf files/*   

#timeout $((60 + RANDOM % 300 ))  $cmd
#cpulimit -l 30 $cmd
sudo echo 3 > /proc/sys/vm/drop_caches
sudo echo 2 > /proc/sys/vm/drop_caches
sudo echo 1 > /proc/sys/vm/drop_caches
$cmd #| parallel -Jcluster 
cd $rootDir/Google-PageRank-cheater-apps_for_teachers_to_track_student_progress/$dir/
sudo rm -rf files/*   

#timeout $((30 + RANDOM % 180 ))  $cmd
#cpulimit -l 30 $cmd
$cmd  #| parallel -Jcluster 
sudo echo 3 > /proc/sys/vm/drop_caches
sudo echo 2 > /proc/sys/vm/drop_caches
sudo echo 1 > /proc/sys/vm/drop_caches
cd $rootDir/Google-PageRank-cheater-apps_music_majesty/$dir/
sudo rm -rf files/*   

#timeout $((1 + RANDOM % 120 ))  $cmd
#cpulimit -l 30 $cmd
$cmd #| parallel -j32 
sudo echo 3 > /proc/sys/vm/drop_caches
sudo echo 2 > /proc/sys/vm/drop_caches
sudo echo 1 > /proc/sys/vm/drop_caches
cd $rootDir/Google-PageRank-cheater-music_practice_tracker/$dir/
sudo rm -rf files/*   

#timeout $((1 + RANDOM % 60 ))  $cmd
#cpulimit -l 30 $cmd
sudo echo 3 > /proc/sys/vm/drop_caches
sudo echo 2 > /proc/sys/vm/drop_caches
sudo echo 1 > /proc/sys/vm/drop_caches
$cmd #| parallel -Jcluster 
cd $rootDir/Google-PageRank-cheater-music_teacher_app/$dir/
sudo rm -rf files/*   

#timeout $((30 + RANDOM % 240 ))  $cmd
#cpulimit -l 30 $cmd
sudo echo 3 > /proc/sys/vm/drop_caches
sudo echo 2 > /proc/sys/vm/drop_caches
sudo echo 1 > /proc/sys/vm/drop_caches
$cmd  #| parallel -Jcluster
cd $rootDir/Google-PageRank-cheater-music_teacher_app/$dir
sudo rm -rf files/*   

#timeout $((60 + RANDOM % 300 ))  $cmd
#cpulimit -l 30 $cmd
$cmd #| parallel -Jcluster 
cd $rootDir/Google-PageRank-cheater-music_teaching_app/$dir/
sudo rm -rf files/*   

#timeout $((60 + RANDOM % 240 ))  $cmd
#cpulimit -l 30 $cmd
sudo echo 3 > /proc/sys/vm/drop_caches
sudo echo 2 > /proc/sys/vm/drop_caches
sudo echo 1 > /proc/sys/vm/drop_caches
$cmd  #| parallel -Jcluster
cd $rootDir/Google-PageRank-cheater-studio_so/$dir/
sudo rm -rf files/*   

#timeout $((60 + RANDOM % 240 ))  $cmd
#cpulimit -l 30 $cmd
sudo echo 3 > /proc/sys/vm/drop_caches
sudo echo 2 > /proc/sys/vm/drop_caches
sudo echo 1 > /proc/sys/vm/drop_caches
$cmd  #| parallel -Jcluster 
cd $rootDir/Google-PageRank-cheater-teacher_student_app/$dir/
sudo rm -rf files/*   

#timeout $((60 + RANDOM % 240 ))  $cmd
#cpulimit -l 30 $cmd
sudo echo 3 > /proc/sys/vm/drop_caches
sudo echo 2 > /proc/sys/vm/drop_caches
sudo echo 1 > /proc/sys/vm/drop_caches
$cmd  #| parallel -Jcluster 

cd $rootDir/Google-PageRank-cheater-ios-music-teach/$dir/
sudo rm -rf files/*   

#timeout $((60 + RANDOM % 240 ))  $cmd
#cpulimit -l 30 $cmd
sudo echo 3 > /proc/sys/vm/drop_caches
sudo echo 2 > /proc/sys/vm/drop_caches
sudo echo 1 > /proc/sys/vm/drop_caches
$cmd  #| parallel -Jcluster 
cd $rootDir/Google-PageRank-cheater-ios-musis-tool/$dir/
sudo rm -rf files/*   

#timeout $((60 + RANDOM % 240 ))  $cmd
#cpulimit -l 30 $cmd
sudo echo 3 > /proc/sys/vm/drop_caches
sudo echo 2 > /proc/sys/vm/drop_caches
sudo echo 1 > /proc/sys/vm/drop_caches
$cmd #| parallel -Jcluster 
cd $rootDir/Google-PageRank-cheater-ios-student/$dir/
sudo rm -rf files/*   

#timeout $((60 + RANDOM % 240 ))  $cmd
#cpulimit -l 30 $cmd
sudo echo 3 > /proc/sys/vm/drop_caches
sudo echo 2 > /proc/sys/vm/drop_caches
sudo echo 1 > /proc/sys/vm/drop_caches
$cmd  #| parallel -Jcluster 
cd $rootDir/Google-PageRank-cheater-ios-teacher/$dir/
sudo rm -rf files/*   

#timeout $((60 + RANDOM % 240 ))  $cmd
#cpulimit -l 30 $cmd
sudo echo 3 > /proc/sys/vm/drop_caches
sudo echo 2 > /proc/sys/vm/drop_caches
sudo echo 1 > /proc/sys/vm/drop_caches
$cmd #| parallel -Jcluster 
cd $rootDir/Google-PageRank-cheater-MUSICED/$dir/
sudo rm -rf files/*   

#timeout $((60 + RANDOM % 240 ))  $cmd
#cpulimit -l 30 $cmd
sudo echo 3 > /proc/sys/vm/drop_caches
sudo echo 2 > /proc/sys/vm/drop_caches
sudo echo 1 > /proc/sys/vm/drop_caches
$cmd  #| parallel -Jcluster 
cd $rootDir/Google-PageRank-cheater-SMARTMUSIC/$dir/
sudo rm -rf files/*   

#timeout $((60 + RANDOM % 240 ))  $cmd
#cpulimit -l 30 $cmd
sudo echo 3 > /proc/sys/vm/drop_caches
sudo echo 2 > /proc/sys/vm/drop_caches
sudo echo 1 > /proc/sys/vm/drop_caches
$cmd #| parallel -Jcluster #this one should aways run 
 
cd $rootDir/Google-PageRank-cheater-SMARTMUSIC-TRAIN-1/$dir/
sudo rm -rf files/*   

#timeout $((60 + RANDOM % 240 ))  $cmd
#cpulimit -l 30 $cmd
sudo echo 3 > /proc/sys/vm/drop_caches
sudo echo 2 > /proc/sys/vm/drop_caches
sudo echo 1 > /proc/sys/vm/drop_caches
$cmd #| parallel -Jcluster #this one should aways run 
cd $rootDir/Google-PageRank-cheater-SMARTMUSIC-AFTER-TRAIN/$dir/
sudo rm -rf files/*   

#timeout $((60 + RANDOM % 240 ))  $cmd
#cpulimit -l 30 $cmd
sudo echo 3 > /proc/sys/vm/drop_caches
sudo echo 2 > /proc/sys/vm/drop_caches
sudo echo 1 > /proc/sys/vm/drop_caches
$cmd #| parallel -Jcluster #this one should aways run 
cd $rootDir/Google-PageRank-cheater-SMART_MUSIC_STUDIOSO/$dir/
sudo rm -rf files/*   

#timeout $((60 + RANDOM % 240 ))  $cmd
#cpulimit -l 30 $cmd
sudo echo 3 > /proc/sys/vm/drop_caches
sudo echo 2 > /proc/sys/vm/drop_caches
sudo echo 1 > /proc/sys/vm/drop_caches
$cmd #| parallel -Jcluster #this one should aways run 
 



#######BOTS 
sudo echo 3 > /proc/sys/vm/drop_caches
sudo echo 2 > /proc/sys/vm/drop_caches
sudo echo 1 > /proc/sys/vm/drop_caches
cd $rootDir/tweet-delete-bot/
node index.js 

sudo echo 3 > /proc/sys/vm/drop_caches
sudo echo 2 > /proc/sys/vm/drop_caches
sudo echo 1 > /proc/sys/vm/drop_caches
#cd $rootDir/like/Twitter_RT-FV_bot/
#timeout $((1 + RANDOM % 600 )) python FV_bot.py  
#python FV_bot.py 

#cd /mnt/HDD/comcasttweetpi
#python comcasttweetpi.py 


#cd $rootDir/like/twitter-bot
#node bot.js 
#cd $rootDir/like/TwitterAutoFavorite 
#python bot.py 


cd $rootDir/GET_FOLLOWERS/twitter-bot-for-increased-growth 
timeout 300 python app.py 

#cd $rootDir/GET_FOLLOWERS/go-twitter-bot 
#./go-twitter-bot 

# /start bot
#sudo bash $rootDir/reply/start.sh
#node $rootDir/reply/reply.js
#sudo bash $rootDir/twitter-contest-js-bot.1/start1.sh*
#sudo bash /mnt/HDD/Programs/Startup.sh
# bash $rootDir/twitter-contest-js-bot.1/start1.sh 
#sudo python /mnt/HDD/tuned-ubuntu/tuned.py 
#node $rootDir/reply/reply.js
#cd $rootDir/reply
#node reply.js
curl -fsS --retry 3 https://hc-ping.com/2db2032d-649c-43b5-947a-cc132f769f5d
sudo bash /mnt/HDD/workspace/keywordCounter/keywordCountertoCSV.sh 
  
killall firefox
sudo /etc/init.d/tor stop
disown -a  && exit 0
