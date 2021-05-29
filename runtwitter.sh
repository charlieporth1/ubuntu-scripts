#!/bin/bash
curl -fsS --retry 3 https://hc-ping.com/6d355eb5-f70e-4409-a598-83f802d182e9
cd /mnt/HDD/workspace/GET_FOLLOWERS/twitter-bot-for-increased-growth/
export IS_PROD=True
#cp -rf ./config.txt.r2 config.txt
#bash ./create_list_script.sh
#cp -rf ./config.txt.r0 config.txt
python app.py
#cp -rf ./config.txt.r1 config.txt
#python app.py
if  [ $? -ne 0 ]; then
        exit 0
else 
        bash $prog/notifywithArgs.sh "$HOSTNAME Twitter bot failed and ended with exit code $?"
	exit 1
fi
