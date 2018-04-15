#bash
LOCAL=$(git rev-parse @ /mnt/HDD/startup/Git/StudiosoStudent_iOS)
REMOTE=$(git rev-parse "https://github.com/StudiosoLLC/StudiosoStudent_iOS")
BASE=$(git merge-base @ "$UPSTREAM")
cd /mnt/HDD/startup/Git
if [ $LOCAL = $REMOTE ]; then
    echo "Up-to-date"
elif [ $LOCAL = $BASE ]; then
    echo "Need to pull"
sudo git clone https://github.com/StudiosoLLC/StudiosoStudent_iOS
sudo git remote -v update
cd /mnt/HDD/HACK/
#sudo gdrive update -r -p 1sscS0H_MzZP9nvBMQ3cUpoIug5aNDDCY /mnt/HDD/HACK/bashbunny-payloads/
# sudo rclone delete -v Gdrive:HACK/bashbunny-payloads 
# sudo rclone copy -v /mnt/HDD/HACK/bashbunny-payloads  Gdrive:HACK/bashbunny-payloads

elif [ $REMOTE = $BASE ]; then
    echo "Need to push"
cd /home/git/Git/StudiosoStudent_iOS/
git push 
else
    echo "Diverged"
fi
