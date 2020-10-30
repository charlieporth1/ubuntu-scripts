#!/bin/bash
. /usr/bin/cred.sh
export word=$(bitch)
. /mnt/HDD/Programs//phoneNumberMN.sh 
export address="@teleflip.com"
sendemail -f $USER@otih-oith.us.to -t $sis -m "You've got mail $word"   -s smtp.gmail.com:587 -o tls=yes -xu $spoofEmail -xp  $spoofPassword
sendemail -f $USER@otih-oith.us.to -t $randomPhone$address -m "You've got mail $word"   -s smtp.gmail.com:587 -o tls=yes -xu $spoofEmail -xp  $spoofPassword
