#!/bin/bash
# GeoIP
sudo geoipupdate
cd /usr/share/GeoIP/
wget https://geolite.maxmind.com/download/geoip/database/GeoLiteCountry/GeoIP.dat.gz
gunzip GeoIP.dat.gz
wget https://geolite.maxmind.com/download/geoip/database/GeoLiteCity.dat.gz
gunzip GeoLiteCity.dat.gz
wget -O  /usr/share/GeoIP/ip-to-country-lite.dat https://db-ip.com/db/download/ip-to-country-lite
wget -O /usr/share/GeoIP/ip-to-city-lite.dat https://db-ip.com/db/download/ip-to-city-lite
wget -O /usr/share/GeoIP/ip-to-asn-lite.dat https://db-ip.com/db/download/ip-to-asn-lite
wget  https://geolite.maxmind.com/download/geoip/database/GeoLite2-City.tar.gz
gunzip GeoLiteCity.tar.gz

# MMDB
sudo geoipupdate
