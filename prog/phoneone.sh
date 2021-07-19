#!/bin/bash
blue='\e[0;34m'
green='\e[0;32m'
cyan='\e[0;36m'
red='\e[0;31m'
yellow='\e[1;33m'
white='\e[1;37m'
nc='\e[0m'

alert="alert"
owner="owner"
Login="Login"
IP="IP"
tracked="tracked"
sent="sent"
sms="sms"
email="email"


export IP_ADD=$(last -1 --time-format notime |  awk '{print $3}' | grepip -o)
if [[ -n "$IP_ADD" ]]; then
	export geoIPCity=`mmdblookup -f /var/lib/GeoIP/GeoLite2-City.mmdb -i $IP_ADD | grep en -A 1 | grep "<utf8_string>" | cut -d "\"" -f 2-2 | xargs`
	export geoIPASN=`mmdblookup -f /var/lib/GeoIP/GeoLite2-ASN.mmdb -i $IP_ADD | grep en -A 1 | grep "<utf8_string>" | cut -d "\"" -f 2-2| xargs`
	export geoIPCountry=`mmdblookup -f /var/lib/GeoIP/GeoLite2-Country.mmdb -i $IP_ADD | grep en -A 1 | grep "<utf8_string>" | cut -d "\"" -f 2-2| xargs`
else
	STR="Private IP of $IP_ADD"
	export geoIPCity="$STR"
	export geoIPASN="$STR"
	export geoIPCountry="$STR"
fi
export loginINFO="Someone has logged into your one of your servers under the User: $USER; and the Server: $HOSTNAME; at the time of $(date); the external IP address of the login was from $IP_ADD; the GeoIP $geoIPCountry; $geoIPCity; the ISP of the login $geoIPASN"
(
	sudo bash $PROG/alert_user.sh "$loginINFO"
)&>/dev/null

echo -e "$yellow$Login $red$alert$nc $yellow$sent$nc to the $yellow$owner$nc of this server via $cyan$sms$nc over $cyan$email$nc"
echo -e "Your IP has been $yellow$tracked$nc; your $yellow$IP$nc address is $red$IP_ADD$nc"
echo -e "Your locations is $geoIPCountry $geoIPCity"
echo -e "If you log-off nothing will happen to you"




