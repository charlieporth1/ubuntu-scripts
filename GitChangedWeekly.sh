#!/usr/bin/parallel --shebang-wrap --pipe /bin/bash

#sudo git clone https://github.com/hak5/bashbunny-payloads.git
#sudo git clone https://github.com/offensive-security/exploit-database.git
#sudo git clone https://github.com/offensive-security/exploit-database-papers.g$
#sudo git clone git@github.com:offensive-security/exploit-database-bin-sploits.$
# git fetch https://github.com/offensive-security/exploit-database-bin-sploits.git
#echo done with that
cd /mnt/HDD/HACK/
#sudo gdrive update -r -p 1sscS0H_MzZP9nvBMQ3cUpoIug5aNDDCY /mnt/HDD/HACK

#UPSTREAM=${1:-'@{u}'}
LOCAL=$(git rev-parse @ /mnt/HDD/HACK/bashbunny-payloads/)
REMOTE=$(git rev-parse "https://github.com/hak5/bashbunny-payloads.git")
BASE=$(git merge-base @ "$UPSTREAM")
cd /mnt/HDD/HACK/
if [ $LOCAL = $REMOTE ]; then
    echo "Up-to-date"
elif [ $LOCAL = $BASE ]; then
    echo "Need to pull"
sudo git clone https://github.com/hak5/bashbunny-payloads.git
sudo git remote -v update
cd /mnt/HDD/HACK/
#sudo gdrive update -r -p 1sscS0H_MzZP9nvBMQ3cUpoIug5aNDDCY /mnt/HDD/HACK/bashbunny-payloads/
 sudo rclone delete -v Gdrive:HACK/bashbunny-payloads 
 sudo rclone copy -v /mnt/HDD/HACK/bashbunny-payloads  Gdrive:HACK/bashbunny-payloads

elif [ $REMOTE = $BASE ]; then
    echo "Need to push"
else
    echo "Diverged"
fi

#!/bin/sh

UPSTREAM=${1:-'@{u}'}
LOCAL=$(git rev-parse @ /mnt/HDD/exploit-database/)
REMOTE=$(git rev-parse "https://github.com/offensive-security/exploit-database.git")
BASE=$(git merge-base @ "$UPSTREAM")

if [ $LOCAL = $REMOTE ]; then
    echo "Up-to-date"
elif [ $LOCAL = $BASE ]; then
    echo "Need to pull"

git clone  https://github.com/offensive-security/exploit-database.git
cd /mnt/HDD/HACK/exploit-database/
sudo git remote -v update
cd /mnt/HDD/HACK/
#sudo gdrive update -r -p 1sscS0H_MzZP9nvBMQ3cUpoIug5aNDDCY /mnt/HDD/HACK/exploit-database/
sudo rclone delete -v Gdrive:HACK/exploit-database
 sudo rclone copy -v /mnt/HDD/HACK/exploit-database  Gdrive:HACK/exploit-database

elif [ $REMOTE = $BASE ]; then
    echo "Need to push"
else
    echo "Diverged"
fi

#!/bin/sh


UPSTREAM=${1:-'@{u}'}
LOCAL=$(git rev-parse @ /mnt/HDD/HACK/exploit-database-papers/)
REMOTE=$(git rev-parse "https://github.com/offensive-security/exploit-database-papers.git")
BASE=$(git merge-base @ "$UPSTREAM")

if [ $LOCAL = $REMOTE ]; then
    echo "Up-to-date"
elif [ $LOCAL = $BASE ]; then
    echo "Need to pull"
git clone https://github.com/offensive-security/exploit-database-papers.git
cd /mnt/HDD/HACK/exploit-database-papers/
sudo git remote -v update
cd /mnt/HDD/HACK/
 rar a /mnt/HDD/HACK/exploit-database-papers.rar -m5 /mnt/HDD/HACK/exploit-database-papers/
sudo delete -v Gdrive:exploit-database-papers
 sudo rclone copy -v /mnt/HDD/HACK/expoit-database-papers  Gdrive:HACK/exploit-database-papers 
#sudo gdrive update -r -p 1sscS0H_MzZP9nvBMQ3cUpoIug5aNDDCY /mnt/HDD/HACK/exploit-database-papers/
elif [ $REMOTE = $BASE ]; then
    echo "Need to push"
else
    echo "Diverged"
fi


UPSTREAM=${1:-'@{u}'}
LOCAL=$(git rev-parse @ /mnt/HDD/HACK/wifipineapple-wiki/)
REMOTE=$(git rev-parse "https://github.com/WiFiPineapple/wifipineapple-wiki")
BASE=$(git merge-base @ "$UPSTREAM")

if [ $LOCAL = $REMOTE ]; then
    echo "Up-to-date"
elif [ $LOCAL = $BASE ]; then
    echo "Need to pull"
git clone https://github.com/WiFiPineapple/wifipineapple-wiki
cd /mnt/HDD/HACK/wifipineapple-wiki
sudo git remote -v update
cd /mnt/HDD/HACK/
sudo delete -v Gdrive:HACK/wifipineapple-wiki
 sudo rclone copy -v /mnt/HDD/HACK/wifipineapple-wiki Gdrive:HACK/wifipineapple-wiki
#sudo gdrive update -r -p 1sscS0H_MzZP9nvBMQ3cUpoIug5aNDDCY /mnt/HDD/HACK/exploit-database-papers/
elif [ $REMOTE = $BASE ]; then
    echo "Need to push"
else
    echo "Diverged"
fi


UPSTREAM=${1:-'@{u}'}
LOCAL=$(git rev-parse @ /mnt/HDD/HACK/bashbunny-wiki)
REMOTE=$(git rev-parse "https://github.com/hak5/bashbunny-wiki")
BASE=$(git merge-base @ "$UPSTREAM")

if [ $LOCAL = $REMOTE ]; then
    echo "Up-to-date"
elif [ $LOCAL = $BASE ]; then
    echo "Need to pull"
git clone https://github.com/hak5/bashbunny-wiki
cd /mnt/HDD/HACK/bashbunny-wiki
sudo git remote -v update
cd /mnt/HDD/HACK/
sudo delete -v Gdrive:HACK/bashbunny-wiki
 sudo rclone copy -v /mnt/HDD/HACK/bashbunny-wiki  Gdrive:HACK/bashbunny-wiki
#sudo gdrive update -r -p 1sscS0H_MzZP9nvBMQ3cUpoIug5aNDDCY /mnt/HDD/HACK/bashbunny-wiki
elif [ $REMOTE = $BASE ]; then
    echo "Need to push"
else
    echo "Diverged"
fi



UPSTREAM=${1:-'@{u}'}
LOCAL=$(git rev-parse @ /mnt/HDD/HACK/wifipineapple-modules/)
REMOTE=$(git rev-parse "https://github.com/hak5/wifipineapple-modules")
BASE=$(git merge-base @ "$UPSTREAM")

if [ $LOCAL = $REMOTE ]; then
    echo "Up-to-date"
elif [ $LOCAL = $BASE ]; then
    echo "Need to pull"
git clone https://github.com/hak5/wifipineapple-modules.git
cd /mnt/HDD/HACK/wifipineapple-modules
sudo git remote -v update
cd /mnt/HDD/HACK/
sudo delete -v Gdrive:HACK/wifipineapple-modules
 sudo rclone copy -v /mnt/HDD/HACK/wifipineapple-modules  Gdrive:HACK/wifipineapple-modules/
#sudo gdrive update -r -p 1sscS0H_MzZP9nvBMQ3cUpoIug5aNDDCY /mnt/HDD/HACK/exploit-database-papers/
elif [ $REMOTE = $BASE ]; then
    echo "Need to push"
else
    echo "Diverged"
fi

#!/bin/sh

UPSTREAM=${1:-'@{u}'}
LOCAL=$(git rev-parse /mnt/HDD/HACK/exploit-database-bin-sploits/)
REMOTE=$(git rev-parse @ "https://github.com/offensive-security/exploit-database-bin-sploits.git")
BASE=$(git merge-base @ "$UPSTREAM")

if [ $LOCAL = $REMOTE ]; then
    echo "Up-to-date"
elif [ $LOCAL = $BASE ]; then
    echo "Need to pull"
git clone https://github.com/offensive-security/exploit-database-bin-sploits.git
cd /mnt/HDD/HACK/exploit-database-bin-sploits/
sudo git remote -v update
cd /mnt/HDD/HACK/
#sudo gdrive update -r -p 1sscS0H_MzZP9nvBMQ3cUpoIug5aNDDCY /mnt/HDD/HACK/exploit-database-bin-sploits/
 
sudo rclone delete -v Gdrive:HACK/exploit-database-bin-spoits 
sudo rclone copy -v /mnt/HDD/HACK/exploit-database-bin-sploits  Gdrive:HACK/exploit-database-bin-sploits
elif [ $REMOTE = $BASE ]; then
    echo "Need to push"
else
    echo "Diverged"
fi


