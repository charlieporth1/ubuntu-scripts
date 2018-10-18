#!/usr/bin/parallel --shebang-wrap --pipe /bin/bash
#!/bin/bash

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

echo -e "$yellow$Login $red$alert$nc $yellow$sent$nc to the $yellow$owner$nc of this server via $cyan$sms$nc over $cyan$email$nc"
export llll=$(last  -1  --time-format notime | grep -e  'ubuntu\|logged in\|pts/*\|tty*' |  sed -n '1p' |  grep -e  'ubuntu\|logged in\|pts/*\|tty*' |  awk '{print $3}'  )
echo -e "Your IP has been $yellow$tracked$nc; your $yellow$IP$nc address is $red$llll$nc"
echo -e "If you log-off nothing will happen to you; if not your fucked"
. /usr/bin/cred.sh
sendemail -f $USER@otih-oith.us.to -t $phonee  -m "Someone has logged into your one of your servers under the User: $USER; and the Server: $HOSTNAME; at the time of $(date); the external IP address of the login was from $llll; the GeoIP $(geoiplookup $llll | grep -i city | cut -d ':' -f 2 | cut -d ',' -f -7 ); the ISP of the login  $(geoiplookup $llll | grep -i ASNum | cut -d ':' -f 2); Was it you: $linkyes $linkno"   -s smtp.gmail.com:587 -o tls=yes -xu $usr -xp  $passwd | GREP_COLOR='01;31' grep --color=always 'successfully!' | GREP_COLOR='01;36' grep  --color=always 'Email' | GREP_COLOR='01;33'  grep  --color=always 'sent'
exit 0




