#!/bin/bash
#fastlane env
. /usr/bin/cred.sh
#echo $itcpwd | sudo nohup watchbuild -a com.studiosoapp.student -u charlieporth@yahoo.com > /mnt/HDD/buildprocessalert.out 2> /mnt/HDD/buildprocessalert.err 
export cmd="/mnt/HDD/watchbuild/bin/watchbuild -a com.studiosoapp.student -u charlieporth@yahoo.com  | awk '{print $2}'  | cut -d '/' -f 13-14  | grep '/'" 
/mnt/HDD/watchbuild/bin/watchbuild -a com.studiosoapp.student -u charlieporth@yahoo.com  | awk '{print $2}'  | cut -d '/' -f 13-14  | grep '/' >  /mnt/HDD/buildstatusvernew.txt
#if [ "$(cat /mnt/HDD/buildstatusver.txt)" != "$cmd" ]
if [ "$(cat /mnt/HDD/buildstatusver.txt)" != "$(cat /mnt/HDD/buildstatusvernew.txt)" ]; then
sudo  /mnt/HDD/watchbuild/bin/watchbuild -a com.studiosoapp.student -u charlieporth@yahoo.com  | awk '{print $2}'  | cut -d '/' -f 13-14  | grep '/'  > /mnt/HDD/buildstatusver.txt
export var='/mnt/HDD/watchbuild/bin/watchbuild -a com.studiosoapp.student -u charlieporth@yahoo.com | grep -o "Successfully finished processing the build"'
#if [ ! -z $( /mnt/HDD/watchbuild/bin/watchbuild -a com.studiosoapp.student -u charlieporth@yahoo.com | grep -o "Successfully finished processing the build" ) ]
if [ ! -z "$var" ]; then 
sendemail -f $USER@otih-oith.us.to -t $phonee  -m "Apple Successfully finished processing the build please submit the app Date: $(date) and Version: $(cat /mnt/HDD/buildstatusver.txt) " -s smtp.gmail.com:587 -o tls=yes -xu $usr  -xp  $passwd
fi
