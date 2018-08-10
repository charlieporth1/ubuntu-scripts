#!/usr/bin/parallel --shebang-wrap --pipe /bin/bash !/bin/sh

#export currloc=$(geoiplookup -f /usr/share/GeoIP/GeoIPCity.dat  $(last  -1 -i -w --time-format notime | grep -e  'ubuntu\|logged in\|pts/*' | cut -c 19-39)  | cut -d "," -f 5 |  cut -d " " -f 2-)
#export currentip=$(last  -1 -i -w --time-format notime | grep -e  'ubuntu\|logged in\|pts/*' | cut -c 19-39)
export  currentip=$(last  -1  -w --time-format notime | grep -e  'ubuntu\|logged in\|pts/*' | awk '{print $3}')
#export mosh="0.0.0.0"
#if (echo $black $currentip =  $mosh ) then
export currloc=$(geoiplookup -f /usr/share/GeoIP/GeoIPCity.dat  $(last -1 --time-format notime | grep -e  'ubuntu\|logged in\|pts/*' | awk '{print $3}')  |  awk '{print $9}' | cut -d "," -f 1)
echo $currloc
if [ -z !$(echo $currloc | awk '{print $2}') ]; then
export finishiedloc=$( echo $currloc | awk '{print $1 "%20" $2}')
elif [ -z !$(echo $currloc | awk '{print $3}') ]; then
export finishiedloc=$( echo $currloc | awk '{print $1 "%20" $2 "%20" $3}')
else 
export finishedloc=$currloc
fi


#URL='http://www.accuweather.com/en/de/berlin/10178/weather-forecast/178087'
#URL='https://www.accuweather.com/en/us/'$currloc'/55424/weather-forecast/333902'
#wget -q -O- "$URL" | awk -F\' '/acm_RecentLocationsCarousel\.push/{print $2": "$16", "$12"°" }'| head -1
#wget -q -O- "$URL" | awk -F\' '/acm_RecentLocationsCarousel\.push/{print $2": "$16", "$12"°", $13 }'| head -1 | cut -d '"' -f 1-2 | awk -F'text:"' '{print $1 $2}'

#wget -q -O- "$URL" | awk -F\' '/acm_RecentLocationsCarousel\.push/{print $2": "$16", Really "$10", Feels like "$12"°", $13  }' | head -1 | cut -d '"' -f 1-2 | awk -F'text:"' '{print $1 $2}'
ansiweather -l $finishedloc -u imperial -a true -s true
exit 1
