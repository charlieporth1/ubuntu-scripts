#!/usr/bin/parallel --shebang-wrap --pipe /bin/bash !/bin/bash

# curl -X POST https://textbelt.com/text \
#       --data-urlencode phone='19523341587' \
#       --data-urlencode message='Someone has logged into one of your servers' \
#       -d key=textbelt
#source /home/ubuntu/.bash_exports 
export blue='\e[0;34m'
export green='\e[0;32m'
export cyan='\e[0;36m'
export red='\e[0;31m'
export yellow='\e[1;33m'
export white='\e[1;37m'
export nc='\e[0m'

export alert="alert"
export owner="owner"
export Login="Login"
export IP="IP"
export tracked="tracked"
export sent="sent"
export sms="sms"
export email="email"
export linkno='http://otih-oith.us.to:3000/IT-WAS-ME/WAS-ME-LOGIN-NO'
export linkyes='http://otih-oith.us.to:3000/IT-WAS-ME/WAS-ME-LOGIN-YES'


export llllip=$(parallel -j16 --xargs --semaphoretimeout 3 bash | last -1 --time-format notime | grep -e 'ubuntu\|logged in\|pts/*\|tty*' | sed -n '1p' | grep -e 'ubuntu\|logged in\|pts/*\|tty*' | awk '{print $3}')
export geo=$(parallel -j16 --xargs --semaphoretimeout 3 bash | geoiplookup $llllip | grep City | cut -d ':' -f 2 | cut -d ',' -f -7)
export isp=$(parallel -j16 --xargs --semaphoretimeout 3 bash | geoiplookup $llllip | grep ASNum | cut -d ':' -f 2)
export loginINFO="Someone has logged into your one of your servers under the User: $USER; and the Server: $HOSTNAME; at the time of $(date); the external IP address of the login was from $llllip; the GeoIP $geo; the ISP of the login $isp; Was it you: $linkyes $linkno"

echo -e "$yellow$Login $red$alert$nc $yellow$sent$nc to the $yellow$owner$nc of this server via $cyan$sms$nc over $cyan$email$nc"
echo -e "Your IP has been $yellow$tracked$nc; your $yellow$IP$nc address is $red$llllip$nc"
echo -e "Your locations is $geo"
echo -e "If you log-off nothing will happen to you; if not your fucked"
. /usr/bin/cred.sh
bash /mnt/HDD/SLACK/slack-bash-bot/bot.sh "$st" '#login' "$HOSTNAME" "$loginINFO" & &> /dev/null
parallel -j16 --xargs --semaphore bash | sendemail -f $USER@otih-oith.us.to -t $phonee -m "$loginINFO" -s smtp.gmail.com:587 -o tls=yes -xu $usr -xp $passwd | GREP_COLOR='01;31' grep --color=always 'successfully!' | GREP_COLOR='01;36' grep --color=always 'Email' | GREP_COLOR='01;33' grep --color=always 'sent'
#parallel -j16 --xargs --semaphore bash | sendemail -f $USER@otih-oith.us.to -t pokeyourfriend@gmail.com  -m ""   -s smtp.gmail.com:587 -o tls=yes -xu $usr -xp  $passwd | GREP_COLOR='01;31' grep --color=always 'successfully!' | GREP_COLOR='01;36' grep  --color=always 'Email' | GREP_COLOR='01;33'  grep  --color=always 'sent' &
#if [ "$HOSTNAME" == 'tegra-ubuntu' ]; then 
#	timeout 600 node /var/www/SMSLinkRECIVED.js & &>/dev/null
#else 
#	ssh tegra-ubuntu "timeout 600 node /var/www/SMSLinkRECIVED.js " & &>/dev/null
#fi




