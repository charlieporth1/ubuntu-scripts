#!/usr/bin/parallel --shebang-wrap -j+64 --pipe /bin/bash
#!/bin/bash
#Better Bots for pageraking and youtubeVieing
#they have random time delays 
#Youtube charlieporth
#15min
#PORT=$(($RANDOM + ($RANDOM % 2) * 32768))
#PORT=$(( ((RANDOM<<15)|RANDOM) % 63001 + 2000 ))
curl -fsS --retry 3 https://hc-ping.com/906c2e51-893d-42bb-9915-16cecdb4f873 
export SHELL=$(type -p bash)
prog=/mnt/HDD/Programs/
debugg=false
function log() {
	if [[ $debugg == true ]]; then
		if [[ -z ${FUNCNAME[1]} ]]; then
			echo "Log message: $1" >&2
		else
			echo "${FUNCNAME[0]} message: Function: ${FUNCNAME[1]}: $1" >&2
		fi
	fi
}
function randomNum() {
	log 'exec randomNum '
	local RANGE=$1
	log "RANGE: $RANGE " 
	local acceptZero=$2
	local number=$RANDOM
	if [[  $acceptZero == true ]]; then
		log "accept ZERO $acceptZero "
		export number=$(( ((RANDOM<<1)|RANDOM) % $RANGE ))
	elif [[ $acceptZero =~ [0-9]^ ]]; then
		log "Number regex; Min number $acceptZero "
		export number=$((((RANDOM<<$acceptZero)|RANDOM) % $RANGE ))
	else
		log "accept ZERO $acceptZero "
		let "number%=$RANGE"
	fi
	log "RANDOM NUMBER: $number "
	echo $number
	return
}
function chooseRandom() {
        log "choosing random"
        declare -a randoms=()
        if [[ -f /dev/urandom ]]; then 
                log '/dev/urandom'
                local urandom=true
                local randoms+=('/dev/urandom')
        fi
        if [[ -f /dev/frandom ]]; then
                log '/dev/frandom'
                local frandom=true
                local randoms+=('/dev/frandom')
        fi
        if [[ -f /dev/erandom ]]; then
                log '/dev/erandom'
                local erandom=true
                local randoms+=('/dev/erandom')
        fi
        if [[ -f /dev/random ]]; then 
                log '/dev/random'
                local randoms+=('/dev/random')
                local random=true
        fi
        local arrayMax=$((${#randoms[@]}))
#        local num=`randomNum $arrayMax false`
 #       local num= #`randomNum $arrayMax false`
#       log "${randoms[@]}"
        export whatRandom=/dev/frandom #${randoms[$num]}
        echo $whatRandom
        log "Array Size: $arrayMax"
        log "CHOOSE RANDOM \#:$num; random: $whatRandom"
}
export whatRandom=/dev/frandom
function randomWait() {
	log 'exec randomWait '
	local range=255
	cutLength
	log "starting hex "
	local hex=`randomHex $range $cutCharMin $cutCharMax`
	log "hex $hex"
	log "hex done"
	local hexRev=`echo "$hex" | rev`
	log "hexRev $hexRev"
	local hexSub=`echo ${numRev:1-0}`
	log "hexSub $hexSub"
	local hexFirstDigit=`echo ${num:0-1} | rev`
	log "hexFirstDigit $hexFirstDigit"
	if [[ $numSub = "F" ]]; then 
		local singleHex=`randomSingleHex`
		log "first char F so choosing a random hex"
		log "hexFirstDigit $singlecHex"
		waitTime=`echo "$(randomSingleHex)$hexSub"`
	else 
		waitTime="$hex"
	fi
	local num=`echo "ibase=16; $waitTime" | bc`
	local msS=1000
	ms=`bc -l <<< "scale=4;$num/1000"`
#	ms=$(($num/ 1000 ))
#	let "ms=/\$num"
#	waitTime=`cat $whatRandom | hexdump | sed -n '$num$p' | bc`
	log "sleeping ms: $ms; dec: $num; hex: $hex; ms: $ms "
	if [[ -n $ms  ]]; then
		echo "sleeping $ms ms"
		sleep $ms
	else
		echo "not sleeping "
	fi
	log "exec done randomWait "
	return
}
function randomHex() {
	log 'exec randomHex '
	local range=$1
	local cutMin=$2
	local cutMax=$3 
	local minusCut=6
	local num=`randomNum $range false`
#	let "minusCut=$cutMin-$cutMax"
	minusCut=$(($cutMax-$cutMin))
	local randomHex=`randomSingleHex`
	local p='p'
	local hex=`head -c $(($num*16+5)) $whatRandom | hexdump | sed -n "$num$p" | cut -c $minusCut-$cutMax | tr " " "$randomHex"`
	local HEX=${hex^^}
	log "exec done with randomHex "
	echo $HEX
	return
}
function cutLength() {
	log 'exec cutLength '
        local range=109
	local maxLength=`randomNum 6 false`
	log "maxLength: $maxLength "
	#sleep 1s
	local charStart=$((9+$maxLength))
	#charMin=`randomNum 8`
	local charMax=`randomNum 32 $charStart`
	log "charMax: $charMax "
	local charSelection=$(( ((RANDOM<<$charStart)|RANDOM) % $charMax ))
	log "selected Char \#: $charSelection "
	log "selected Char \# min: $maxLength "
#	selectHex=`randomNum $charSelection`
#	hexSelection=$(( ((RANDOM<<)|RANDOM) % 32 ))
	local p='p'
#	let "charStart=$maxLength-$charSelection"
	local charStart=$(($charSelection-$maxLength))
#	hex=`head -c $(($range+5)) $whatRandom | hexdump | sed -n '$number$p' | cut -c $charStart-$charSelection | sed 's/\ //g'`
#	export cutCharMin=$charMin
	export cutCharMin=$maxLength
	export cutCharMax=$charSelection
	export charSelection=$charSelection
	export maxLength=$maxLength
	log "done cutLength "
	return
}
function randomSingleHex() {
	log "exec randomSingleHex "
        local range=18
	local minus=6 # this make sure there are chars 
	local num=`randomNum $range false`
	local minChar=$((10+$minus))
	local charStart=2
	#local charMin=`randomNum 8`
	local charMax=`randomNum 32 $minChar`
	log "charMax $charMax"
	local charSelection=$(( ((RANDOM<<$minChar)|RANDOM) % $charMax ))
	log "charSelection $charSelection"
	local p='p'
	#if [[ $charMin < $charMax ]]; then
	let "charStart=$minus-$charSelection"
	local charStart=$(($charSelection-$minus))
#	local charStart=$(($minus-$charSelection))
	log "charStart $charStart"
	#fi
	local hexa=`head -c $(($num*16+6)) $whatRandom | hexdump | sed -n "$num$p" | cut -c $charStart-$charSelection | sed "s/ //g"`
	#if [[  $hex =~ [[:space:]]* ]]; then
	#	log "found spaces"
	#	local hexa=`echo $hex | sed 's/ //g'`
	#else 
	#	local hexa=${hex} 
	#fi 
	log "hexa $hexa"
#	log "hex $hex"
	local hexadecimal=`echo ${hexa^^} | cut -c 1-1`
	log "hexadecimal $hexadecimal"
	echo $hexadecimal
	log "done randomSingleHex "
	return
}
export -f randomSingleHex 
export -f cutLength
export -f randomNum
export -f randomWait
export -f randomHex
function killBots() {
	for process in `sudo ps -x | grep Bots.sh | awk '{print $1}'`
	do
		kill $process
		kill -9 $process
		log "process killed $process"
	done
}

function onlyOnce() {
	curl -fsS --retry 3 https://hc-ping.com/906c2e51-893d-42bb-9915-16cecdb4f873 
#	isRunning=`sudo ps -x |  grep -o "Bots.sh"`
#	isRunning=`sudo ps -x | grep "Bots.sh" | grep -v 'grep --color=auto Bots.sh'`
	local isRunning=`sudo ps -x | grep "Bots.sh" | grep -v  'grep Bots.sh'`
	local isThisOne=`echo $isRunning | awk '{print $4}' | sort  -k4 | tail +3` ##this is the simplest way to do this for loop is the other option for making sure 
	log "isRunning $isRunning"
	log "isThisOne $isThisOne"
	local echo `date` | cut -d ':' -f 1 | awk '{print $4}'
	local randomHour=$((`randomNum 23`)) 
	echo `date` | cut -d ':' -f 1 | awk '{print $4}'
	if [ $randomHour == ]; then

	fi 
	if [[ -n $isRunning && -n $isThisOne ]]; then
		echo "already running"
		log "already running"
		echo "ending process"
		log "ending process"
		curl -fsS --retry 3 https://hc-ping.com/2db2032d-649c-43b5-947a-cc132f769f5d
#		torOff
		sleep 10s
		exit 0
	fi
}
function torOn() {
	randomWait
	sudo /etc/init.d/tor start
	sleep 0.1
	sudo service privoxy start
	sleep 0.1
	return
}
function torOff() {

	sudo /etc/init.d/tor stop
	sleep 0.1
	sudo service privoxy stop
	sleep 0.1
	bash $prog/cleanTmpIfFull.sh
	return
}
function clearRAM() {
	sync
	sudo echo 3 > /proc/sys/vm/drop_caches
	sudo echo 2 > /proc/sys/vm/drop_caches
	sudo echo 1 > /proc/sys/vm/drop_caches
	sync
	return
}
onlyOnce
#chooseRandom
#sleep 5s
torOn
useChrome=true
if [[ $useChrome == true ]]; then
	echo 'using chrome'
	log "using chrome"
	chromium-browser --headless --no-sandbox &
else
	echo 'using fire'
	log "using fire"
	firefox --headless &
fi
headless=false #this is the headless bot not browser 
export rootDir=/mnt/HDD/workspace
if [[ $headless == true ]]; then
	echo "using headless"
	log "using headless"
	export dir=Google-PageRank-cheater-headless/
	export cmd=./main
else
	echo "using browser aided headless"
	log "using browser aided headless"
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
torOff
torOn
cd $rootDir/Google-PageRank-cheater-Twitter/$dir/
clearRAM
$cmd #| parallel -Jcluster #this one should aways run 
torOff
torOn
cd $rootDir/Google-PageRank-cheater-Facebook/$dir/
clearRAM
$cmd #| parallel -Jcluster #this one should aways run 

sleep 5

if [ $useChrome == true ]; then
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
