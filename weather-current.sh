#!/bin/sh

export currloc=$(geoiplookup -f /usr/share/GeoIP/GeoIPCity.dat  $(last  -1 -i -w --time-format notime | grep -e  'ubuntu\|logged in\|pts/*' | cut -c 19-39)  | cut -d "," -f 5 |  cut -d " " -f 2-)
echo $currloc
#URL='http://www.accuweather.com/en/de/berlin/10178/weather-forecast/178087'
URL='https://www.accuweather.com/en/us/'$currloc'/55424/weather-forecast/333902'
wget -q -O- "$URL" | awk -F\' '/acm_RecentLocationsCarousel\.push/{print $2": "$16", "$12"°" }'| head -1
