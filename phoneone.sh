
#!/bin/bash !/usr/bin/parallel --shebang-wrap --pipe /bin/bash
# curl -X POST https://textbelt.com/text \
#       --data-urlencode phone='19523341587' \
#       --data-urlencode message='Someone has logged into one of your servers' \
#       -d key=textbelt
echo "Login alert sent to the owner of this server"
export llll=$(last  -1  --time-format notime | grep -e  'ubuntu\|logged in\|pts/*\|tty*' |  sed -n '1p' |  grep -e  'ubuntu\|logged in\|pts/*\|tty*' |  awk '{print $3}' )
echo "Your IP has been tracked; your IP address is $llll"
echo "If you log-off nothing will happen to you; if not your fucked"
. /usr/bin/cred.sh
sendemail -f $USER@otih-oith.us.to -t $phonee  -m "Someone has logged into your one of your servers under the User: $USER; and the Server: $HOSTNAME; at the time of $(date); the external IP address of the login was from $llll; the GeoIP $(geoiplookup $llll | grep -i city | cut -d ':' -f 2 | cut -d ',' -f -7 ); the ISP of the login  $(geoiplookup $llll | grep -i ASNum | cut -d ':' -f 2  )"   -s smtp.gmail.com:587 -o tls=yes -xu $usr -xp  $passwd





