#!/bin/bash
. /usr/bin/cred.sh
sendemail  -f $USER@otih-oith.us.to -t $phonee -u "Xcode Build Complete" -m "Your Xcode build is complete please go back to your computer $(date)" -s smtp.gmail.com:587 -o tls=auto -xu $email  -xp $passwd -o message-content-type=text 
#-o message-header=""
