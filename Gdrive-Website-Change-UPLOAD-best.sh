cd /var/www

if [[ `git status --porcelain` ]]; then
  # Changes
echo changes
git add .
git rm --cached -r .git
git commit -m date
git push | parallel -j128 -Jcluster
#sudo git remote -v update
cd /var
#sudo gdrive update -r -p 1sscS0H_MzZP9nvBMQ3cUpoIug5aNDDCY /mnt/HDD/HACK/bashbunny-payloads/
sudo rclone copy -v /var/www/ Gdrive:www   | parallel -j128 -Jcluster 
sudo rclone copy -v /var/www/ Gdrive:www  | parallel -j128 -Jcluster 
else
echo no changes
  # No changes
fi
