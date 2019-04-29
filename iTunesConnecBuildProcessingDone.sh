#!/bin/bash
#fastlane env
curl -fsS --retry 3 https://hc-ping.com/64b266e2-f3d4-4d82-b8ee-43a65e884476
. /usr/bin/cred.sh
#echo $itcpwd | sudo nohup watchbuild -a com.studiosoapp.student -u charlieporth@yahoo.com > /mnt/HDD/buildprocessalert.out 2> /mnt/HDD/buildprocessalert.err 
export cmd="$(/mnt/HDD/watchbuild/bin/watchbuild -a com.studiosoapp.student -u charlieporth@yahoo.com  | awk '{print $2}'  | cut -d '/' -f 13-14  | grep '/')" 
export cmdT="$(/mnt/HDD/watchbuild/bin/watchbuild -a com.Studioso-teacher -u charlieporth@yahoo.com  | awk '{print $2}'  | cut -d '/' -f 13-14  | grep '/')" 
export pre="$(cat /mnt/HDD/buildstatusver.txt)"
export preT="$(cat /mnt/HDD/buildstatusverT.txt)"
sudo echo "$cmdT" #> /mnt/HDD/buildstatusverT.txt
sudo echo "$cmd" #> /mnt/HDD/buildstatusver.txt
echo "cmd: " $cmd
echo "pre: " $pre
echo "cmdT: " $cmdT
echo "preT: " $preT
if [[ "$preT" != "$cmdT" ]]; then
	sudo echo $cmdT  > /mnt/HDD/buildstatusverT.txt
	export var=$(/mnt/HDD/watchbuild/bin/watchbuild -a com.studiosoapp.student -u charlieporth@yahoo.com | grep -o "Successfully finished processing the build")
	echo "var " $var
	if [ ! -z "$var" ]; then 
		sendemail -f $USER@otih-oith.us.to -t $phonee  -m "Apple Successfully finished processing the build STUDENT please submit the app Date: $(date) and Version: $(cat /mnt/HDD/buildstatusver.txt) " -s smtp.gmail.com:587 -o tls=yes -xu $usr  -xp  $passwd
	else
		echo "not done"
	fi
else
	echo "is equal"
fi
if [[ "$pre" != "$cmd" ]]; then
	sudo echo $cmd  > /mnt/HDD/buildstatusver.txt
	export varT=$(/mnt/HDD/watchbuild/bin/watchbuild -a com.Studioso-teacher -u charlieporth@yahoo.com | grep -o "Successfully finished processing the build")
	echo "varT " $varT
	if [ ! -z "$varT" ]; then 
		sendemail -f $USER@otih-oith.us.to -t $phonee  -m "Apple Successfully finished processing the build TEACHER please submit the app Date: $(date) and Version: $(cat /mnt/HDD/buildstatusver.txt) " -s smtp.gmail.com:587 -o tls=yes -xu $usr  -xp  $passwd
	else
		echo "not done"
	fi

else
	echo "is equal"
fi


exit 0
