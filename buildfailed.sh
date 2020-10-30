#!/bin/bash
. /usr/bin/cred.sh
sendemail -f $USER@otih-oith.us.to -t $phonee  -m "Your Xcode build is FAILED please go back to your computer"   -s smtp.gmail.com:587 -o tls=yes -xu $usr -xp  $passwd

