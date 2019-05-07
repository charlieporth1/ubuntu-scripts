#!/usr/bin/parallel --shebang-wrap -j+64 --pipe /bin/bash
#!/bin/bash
#Better Bots for pageraking and youtubeVieing
#they have random time delays 
#Youtube charlieporth
#15min
#PORT=$(($RANDOM + ($RANDOM % 2) * 32768))
#PORT=$(( ((RANDOM<<15)|RANDOM) % 63001 + 2000 ))
curl -fsS --retry 3 https://hc-ping.com/906c2e51-893d-42bb-9915-16cecdb4f873 
function randomWait() {
	range=255
	hex=`randomHex $range`
	hexRev=`echo $hex | rev`
	hexSub=echo ${numRev:1-0}
	hexFirstDigit=echo ${num:0-1} | rev
	singleHex=`randomSingleHex`
	if [[ $numSub = "F" ]]; then 
		waitTime=`echo "$(randomSingleHex)$hexSub"`
	else 
		waitTime=`echo "$hex"`
	fi
	num=`echo "base=16; $waitTime" | bc`
	ms=1000
	let "ms = 1000 / $num"
#	waitTime=`cat /dev/urandom | hexdump | sed -n '$num$p' | bc`
	echo "sleeping (ms): dec: $num; hex: $hex; ms: $ms"
	sleep $ms
}
function randomHex() {
	range=$1
	cutMin=$2
	cutMax=$3 
	randomHex=`randomSingleHex`
	num=`randomNum $range`
	p='p'
	hex=`head -c $range+5 /dev/urandom | hexdump | sed -n '$num$p' | cut -c $cutMin-$cutMax | tr " " "$randomHex"`
	HEX=${hex^^}
	return $HEX
}
function randomNum() {
	RANGE=$1
	number=$RANDOM
	let "number %= $RANGE"
	return $number
}
function cutLength() {
        range=109
	maxLength=`randomNum 6`
	charMin=`randomNum 8`
	charMax=`randomNum 32`
	charSelection=$(( ((RANDOM<<8)|RANDOM) % 32 ))
	charStart=8
	let "charStart = $maxLength - $charSelection"
	hex=`head -c $range+5 /dev/urandom | hexdump | sed -n '$number$p' | cut -c $charStart-$charSelection | sed 's/ //g'`
}
function randomSingleHex() {
        range=18
	num=`randomNum $range`
	maxLength=`randomNum 6`
	charMin=`randomNum 8`
	charMax=`randomNum 32`
	charSelection=$(( ((RANDOM<<8)|RANDOM) % 32 ))
	charStart=2
	minus=1
	if [[ $charMin < $charMax ]]; then
		let "charStart = $maxLength - $charSelection"
	else
		while true; do
			if [[ $charMax < $charMax ]]; then 
				let "charStart = $maxLength - $charSelection"
				break
			else
				continue
			fi
		done
	fi
	p='p'
	hex=`head -c $num+5 /dev/urandom | hexdump | sed -n '$num$p' | cut -c $charStart-$charSelection | sed 's/ //g'`
	return $hex
}
randomWait
function torOn() {

	sudo /etc/init.d/tor start
	sleep 1
	sudo service privoxy start
	sleep 2
}
function torOff() {

	sudo /etc/init.d/tor stop
	sleep 1
	sudo service privoxy stop
	sleep 2
	rm -rf /tmp/*
	sleep 1
}
function clearRAM() {
	sudo echo 3 > /proc/sys/vm/drop_caches
	sudo echo 2 > /proc/sys/vm/drop_caches
	sudo echo 1 > /proc/sys/vm/drop_caches
	sync
}
torOn
useChrome=true
if [ $useChrome ]; then
	chromium-browser --headless --no-sandbox &
else
	firefox --headless &
fi
headless=false #this is the headless bot not browser 
export rootDir=/mnt/HDD/workspace
if [ $headless ]; then
	export dir=Google-PageRank-cheater-headless/
	export cmd=./main
else
	export dir=Google-PageRank-cheater-browser-aided/
	export cmd=./google
fi 
randomWait
cd $rootDir/YouTube-View-increaser
#timeout $((1 + RANDOM % 900 )) ./youtube 
#./youtube 
#Studioso music app keyword
clearRAM
cd $rootDir/Google-PageRank-cheater-Studioso-Keyword-Music-app/$dir/
sudo rm -rf files/*
##5min
#cpulimit -l 30 $cmd
$cmd   #| parallel -Jcluster 
clearRAM
#timeout $((60 + RANDOM % 300 ))  $cmd
# studioso google cheat bot with the keyword music educatio 
torOff
torOn
cd $rootDir/Google-PageRank-cheater-Studioso1-conf/$dir 
sudo rm -rf files/*

#600 seconds == ten min
#timeout $((55 + RANDOM % 600 )) $cmd
#cpulimit -l 30 $cmd
$cmd  #| parallel -Jcluster 
clearRAM
# otih oith bot
torOff
torOn
cd $rootDir/Google-PageRank-cheater-OTIH-OITH-Conf/$dir
sudo rm -rf files/*

#3min
#timeout $((55 + RANDOM % 180 ))  $cmd
#cpulimit -l 30 $cmd
$cmd #| parallel -Jcluster 
clearRAM
torOff
torOn
cd $rootDir/Google-PageRank-cheater/$dir 
sudo rm -rf files/*

$cmd 
#timeout $((1 + RANDOM % 180 )) $cmd
echo done with that
echo done with that
echo done with that
echo done with that
echo done with that
clearRAM
#apps_for_music_teacher
torOff
torOn
cd $rootDir/Google-PageRank-cheater-apps_for_music_teachers/$dir/
sudo rm -rf files/*   

#timeout $((15 + RANDOM % 180 ))  $cmd
#cpulimit -l 30 $cmd
clearRAM
 $cmd #| parallel -Jcluster 
torOff
torOn
cd $rootDir/Google-PageRank-cheater-apps_for_teachers_to_track_student_progress/$dir/
sudo rm -rf files/*   

#timeout $((60 + RANDOM % 300 ))  $cmd
#cpulimit -l 30 $cmd
clearRAM
$cmd #| parallel -Jcluster 
torOff
torOn
cd $rootDir/Google-PageRank-cheater-apps_for_teachers_to_track_student_progress/$dir/
sudo rm -rf files/*   

#timeout $((30 + RANDOM % 180 ))  $cmd
#cpulimit -l 30 $cmd
$cmd  #| parallel -Jcluster 
sudo echo 3 > /proc/sys/vm/drop_caches
sudo echo 2 > /proc/sys/vm/drop_caches
sudo echo 1 > /proc/sys/vm/drop_caches
torOff
torOn
cd $rootDir/Google-PageRank-cheater-apps_music_majesty/$dir/
sudo rm -rf files/*   

#timeout $((1 + RANDOM % 120 ))  $cmd
#cpulimit -l 30 $cmd
$cmd #| parallel -j32 
clearRAM
torOff
torOn
cd $rootDir/Google-PageRank-cheater-music_practice_tracker/$dir/
sudo rm -rf files/*   

#timeout $((1 + RANDOM % 60 ))  $cmd
#cpulimit -l 30 $cmd
clearRAM
$cmd #| parallel -Jcluster 
torOff
torOn
cd $rootDir/Google-PageRank-cheater-music_teacher_app/$dir/
sudo rm -rf files/*   

#timeout $((30 + RANDOM % 240 ))  $cmd
#cpulimit -l 30 $cmd
clearRAM
$cmd  #| parallel -Jcluster
torOff
torOn
cd $rootDir/Google-PageRank-cheater-music_teacher_app/$dir
sudo rm -rf files/*   

#timeout $((60 + RANDOM % 300 ))  $cmd
#cpulimit -l 30 $cmd
$cmd #| parallel -Jcluster 
torOff
torOn
cd $rootDir/Google-PageRank-cheater-music_teaching_app/$dir/
sudo rm -rf files/*   

#timeout $((60 + RANDOM % 240 ))  $cmd
#cpulimit -l 30 $cmd
clearRAM
$cmd  #| parallel -Jcluster
torOff
torOn
cd $rootDir/Google-PageRank-cheater-studio_so/$dir/
sudo rm -rf files/*   

#timeout $((60 + RANDOM % 240 ))  $cmd
#cpulimit -l 30 $cmd
clearRAM
$cmd  #| parallel -Jcluster 
torOff
torOn
cd $rootDir/Google-PageRank-cheater-teacher_student_app/$dir/
sudo rm -rf files/*   

#timeout $((60 + RANDOM % 240 ))  $cmd
#cpulimit -l 30 $cmd
clearRAM
$cmd  #| parallel -Jcluster 
torOff
torOn

cd $rootDir/Google-PageRank-cheater-ios-music-teach/$dir/
sudo rm -rf files/*   

#timeout $((60 + RANDOM % 240 ))  $cmd
#cpulimit -l 30 $cmd
clearRAM
torOff
torOn
$cmd  #| parallel -Jcluster 
cd $rootDir/Google-PageRank-cheater-ios-musis-tool/$dir/
sudo rm -rf files/*   

#timeout $((60 + RANDOM % 240 ))  $cmd
#cpulimit -l 30 $cmd
clearRAM
$cmd #| parallel -Jcluster 
torOff
torOn
cd $rootDir/Google-PageRank-cheater-ios-student/$dir/
sudo rm -rf files/*   

#timeout $((60 + RANDOM % 240 ))  $cmd
#cpulimit -l 30 $cmd
clearRAM
$cmd  #| parallel -Jcluster 
torOff
torOn
cd $rootDir/Google-PageRank-cheater-ios-teacher/$dir/
sudo rm -rf files/*   

#timeout $((60 + RANDOM % 240 ))  $cmd
#cpulimit -l 30 $cmd
clearRAM
$cmd #| parallel -Jcluster 
torOff
torOn
cd $rootDir/Google-PageRank-cheater-MUSICED/$dir/
sudo rm -rf files/*   

#timeout $((60 + RANDOM % 240 ))  $cmd
#cpulimit -l 30 $cmd
clearRAM
$cmd  #| parallel -Jcluster 
torOff
torOn
cd $rootDir/Google-PageRank-cheater-SMARTMUSIC/$dir/
sudo rm -rf files/*   

#timeout $((60 + RANDOM % 240 ))  $cmd
#cpulimit -l 30 $cmd
clearRAM
$cmd #| parallel -Jcluster #this one should aways run 
torOff
torOn
 
cd $rootDir/Google-PageRank-cheater-SMARTMUSIC-TRAIN-1/$dir/
sudo rm -rf files/*   

#timeout $((60 + RANDOM % 240 ))  $cmd
#cpulimit -l 30 $cmd
clearRAM
$cmd #| parallel -Jcluster #this one should aways run 
torOff
torOn
cd $rootDir/Google-PageRank-cheater-SMARTMUSIC-AFTER-TRAIN/$dir/
sudo rm -rf files/*   

#timeout $((60 + RANDOM % 240 ))  $cmd
#cpulimit -l 30 $cmd
clearRAM
$cmd #| parallel -Jcluster #this one should aways run 
torOff
torOn
cd $rootDir/Google-PageRank-cheater-SMART_MUSIC_STUDIOSO/$dir/
sudo rm -rf files/*   
#timeout $((60 + RANDOM % 240 ))  $cmd
#cpulimit -l 30 $cmd
clearRAM
$cmd #| parallel -Jcluster #this one should aways run 
sleep 5
if [ $useChrome ]; then
	killall chromium-browser
else
	killall firefox
fi
 



#######BOTS 
clearRAM
cd $rootDir/tweet-delete-bot/
node index.js 

clearRAM
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
#timeout 300 
python app.py 
clearRAM

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
disown -a  && exit 0
