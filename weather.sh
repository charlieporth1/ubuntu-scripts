#!/bin/sh

#URL='http://www.accuweather.com/en/de/berlin/10178/weather-forecast/178087'
URL='https://www.accuweather.com/en/us/edina-mn/55424/weather-forecast/333902'
#wget -q -O- "$URL" | awk -F\' '/acm_RecentLocationsCarousel\.push/{print $2": "$16", "$12"°" }'| head -1
wget -q -O- "$URL" | awk -F\' '/acm_RecentLocationsCarousel\.push/{print $2": "$16", "$12"°", $13 }'| head -1 | cut -d '"' -f 1-2 | awk -F'text:"' '{print $1 $2}'
exit 1
