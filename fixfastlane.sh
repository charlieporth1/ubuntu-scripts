#!/bin/bash
. /usr/bin/cred.sh
cd /mnt/HDD/itunes-connect-slack/
fastlane env
echo 1 | bundle exec fastlane 
echo "$psswd" | bundle update fastlane
killall bundle
killall -9 bundle
killall -8 bundle
killall ruby2.5
#killall ruby
