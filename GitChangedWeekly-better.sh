#!/usr/bin/parallel --shebang-wrap --pipe /bin/bash

cd /mnt/HDD/HACK/
cd /mnt/HDD/HACK/bashbunny-payloads

if [[ `git status --porcelain` ]]; then
  # Changes
echo changes
git commit -m "$(date)"
git pull | parallel -Jcluster
sudo echo 3 > /proc/sys/vm/drop_caches
sudo echo 2 > /proc/sys/vm/drop_caches
sudo echo 1 > /proc/sys/vm/drop_caches
#sudo git remote -v update
cd /mnt/HDD/HACK/ 
#sudo gdrive update -r -p 1sscS0H_MzZP9nvBMQ3cUpoIug5aNDDCY /mnt/HDD/HACK/bashbunny-payloads/
 sudo rclone delete -v Gdrive:HACK/bashbunny-payloads  | parallel -Jcluster
 sudo rclone copy -v /mnt/HDD/HACK/bashbunny-payloads  Gdrive:HACK/bashbunny-payloads | parallel -Jcluster
sudo echo 3 > /proc/sys/vm/drop_caches
sudo echo 2 > /proc/sys/vm/drop_caches
sudo echo 1 > /proc/sys/vm/drop_caches

else
echo no changes
  # No changes
fi


cd /mnt/HDD/HACK/exploit-database/

if [[ `git status --porcelain` ]]; then
  # Changes
echo changes
git commit -m "$(date)"
git pull | parallel -Jcluster
sudo echo 3 > /proc/sys/vm/drop_caches
sudo echo 2 > /proc/sys/vm/drop_caches
sudo echo 1 > /proc/sys/vm/drop_caches

#sudo git remote -v update
cd /mnt/HDD/HACK/ 
#sudo gdrive update -r -p 1sscS0H_MzZP9nvBMQ3cUpoIug5aNDDCY /mnt/HDD/HACK/bashbunny-payloads/
 sudo rclone delete -v Gdrive:HACK/exploit-database | parallel -Jcluster
 sudo rclone copy -v /mnt/HDD/HACK/exploit-database  Gdrive:HACK/exploit-database | parallel -Jcluster
sudo echo 3 > /proc/sys/vm/drop_caches
sudo echo 2 > /proc/sys/vm/drop_caches
sudo echo 1 > /proc/sys/vm/drop_caches

else
echo no changes
  # No changes
fi


if [[ `git status --porcelain` ]]; then
  # Changes
echo changes
git commit -m "$(date)"
git pull | parallel  -Jcluster
sudo echo 3 > /proc/sys/vm/drop_caches
sudo echo 2 > /proc/sys/vm/drop_caches
sudo echo 1 > /proc/sys/vm/drop_caches
#sudo git remote -v update
cd /mnt/HDD/HACK/ 
#sudo gdrive update -r -p 1sscS0H_MzZP9nvBMQ3cUpoIug5aNDDCY /mnt/HDD/HACK/bashbunny-payloads/
sudo delete -v Gdrive:exploit-database-papers | parallel -Jcluster
 sudo rclone copy -v /mnt/HDD/HACK/expoit-database-papers  Gdrive:HACK/exploit-database-papers  | parallel -Jcluster
sudo echo 3 > /proc/sys/vm/drop_caches
sudo echo 2 > /proc/sys/vm/drop_caches
sudo echo 1 > /proc/sys/vm/drop_caches
else
echo no changes
  # No changes
fi



cd /mnt/HDD/HACK/wifipineapple-wiki/

if [[ `git status --porcelain` ]]; then
  # Changes
echo changes
git commit -m "$(date)"
git pull | parallel -Jcluster
sudo echo 3 > /proc/sys/vm/drop_caches
sudo echo 2 > /proc/sys/vm/drop_caches
sudo echo 1 > /proc/sys/vm/drop_caches
#sudo git remote -v update
cd /mnt/HDD/HACK/ 
#sudo gdrive update -r -p 1sscS0H_MzZP9nvBMQ3cUpoIug5aNDDCY /mnt/HDD/HACK/bashbunny-payloads/
sudo delete -v Gdrive:HACK/wifipineapple-wiki | parallel -Jcluster
 sudo rclone copy -v /mnt/HDD/HACK/wifipineapple-wiki Gdrive:HACK/wifipineapple-wiki | parallel -Jcluster
sudo echo 3 > /proc/sys/vm/drop_caches
sudo echo 2 > /proc/sys/vm/drop_caches
sudo echo 1 > /proc/sys/vm/drop_caches
else
echo no changes
  # No changes
fi

cd /mnt/HDD/HACK/bashbunny-wiki

if [[ `git status --porcelain` ]]; then
  # Changes
echo changes
git commit -m "$(date)"
git pull | parallel -Jcluster
sudo echo 3 > /proc/sys/vm/drop_caches
sudo echo 2 > /proc/sys/vm/drop_caches
sudo echo 1 > /proc/sys/vm/drop_caches

#sudo git remote -v update
cd /mnt/HDD/HACK/ 
#sudo gdrive update -r -p 1sscS0H_MzZP9nvBMQ3cUpoIug5aNDDCY /mnt/HDD/HACK/bashbunny-payloads/
sudo delete -v Gdrive:HACK/bashbunny-wiki  | parallel -Jcluster
 sudo rclone copy -v /mnt/HDD/HACK/bashbunny-wiki  Gdrive:HACK/bashbunny-wiki  | parallel -Jcluster
sudo echo 3 > /proc/sys/vm/drop_caches
sudo echo 2 > /proc/sys/vm/drop_caches
sudo echo 1 > /proc/sys/vm/drop_caches
else
echo no changes
  # No changes
fi
cd /mnt/HDD/HACK/wifipineapple-modules/

if [[ `git status --porcelain` ]]; then
  # Changes
echo changes
git commit -m "$(date)"
git pull | parallel -Jcluster
sudo echo 3 > /proc/sys/vm/drop_caches
sudo echo 2 > /proc/sys/vm/drop_caches
sudo echo 1 > /proc/sys/vm/drop_caches
#sudo git remote -v update
cd /mnt/HDD/HACK/ 
#sudo gdrive update -r -p 1sscS0H_MzZP9nvBMQ3cUpoIug5aNDDCY /mnt/HDD/HACK/bashbunny-payloads/
sudo delete -v Gdrive:HACK/wifipineapple-modules | parallel -Jcluster
 sudo rclone copy -v /mnt/HDD/HACK/wifipineapple-modules  Gdrive:HACK/wifipineapple-modules | parallel -Jcluster
sudo echo 3 > /proc/sys/vm/drop_caches
sudo echo 2 > /proc/sys/vm/drop_caches
sudo echo 1 > /proc/sys/vm/drop_caches

else
echo no changes
  # No changes
fi

cd /mnt/HDD/HACK//exploit-database-bin-sploits/

if [[ `git status --porcelain` ]]; then
  # Changes
echo changes
git commit -m "$(date)"
git pull | parallel -Jcluster
sudo echo 3 > /proc/sys/vm/drop_caches
sudo echo 2 > /proc/sys/vm/drop_caches
sudo echo 1 > /proc/sys/vm/drop_caches

#sudo git remote -v update
cd /mnt/HDD/HACK/ 
#sudo gdrive update -r -p 1sscS0H_MzZP9nvBMQ3cUpoIug5aNDDCY /mnt/HDD/HACK/bashbunny-payloads/
sudo rclone delete -v Gdrive:HACK/exploit-database-bin-spoits  | parallel -Jcluster
sudo rclone copy -v /mnt/HDD/HACK/exploit-database-bin-sploits  Gdrive:HACK/exploit-database-bin-sploits | parallel -Jcluster
sudo echo 3 > /proc/sys/vm/drop_caches
sudo echo 2 > /proc/sys/vm/drop_caches
sudo echo 1 > /proc/sys/vm/drop_caches

else
echo no changes
  # No changes
fi
cd /mnt/HDD/HACK/PINEAPPLE
git clone --recurse-submodules -j8 ./ | parallel -Jcluster
git add . | parallel -Jcluster
git commit -m "$(date)" | parallel -Jcluster
sudo echo 3 > /proc/sys/vm/drop_caches
sudo echo 2 > /proc/sys/vm/drop_caches
sudo echo 1 > /proc/sys/vm/drop_caches

if [[ `git status --porcelain` ]]; then
  # Changes
echo changes
git push | parallel -Jcluster
cd /mnt/HDD/HACK/PINEAPPLE 
#sudo gdrive update -r -p 1sscS0H_MzZP9nvBMQ3cUpoIug5aNDDCY /mnt/HDD/HACK/bashbunny-payloads/
sudo rclone delete -v Gdrive:HACK/PINEAPPLE  | parallel -Jcluster
sudo rclone copy -v /mnt/HDD/HACK/PINEAPPLE  Gdrive:HACK/PINEAPPLE | parallel -Jcluster
sudo echo 3 > /proc/sys/vm/drop_caches
sudo echo 2 > /proc/sys/vm/drop_caches
sudo echo 1 > /proc/sys/vm/drop_caches

else
echo no changes
  # No changes
fi
cd /mnt/HDD/HACK/BB
git clone --recurse-submodules -j8 ./ | parallel -Jcluster
git commit -m "$(date)" | parallel -Jcluster
sudo echo 3 > /proc/sys/vm/drop_caches
sudo echo 2 > /proc/sys/vm/drop_caches
sudo echo 1 > /proc/sys/vm/drop_caches

if [[ `git status --porcelain` ]]; then
  # Changes
echo changes
git push | parallel -Jcluster
cd /mnt/HDD/HACK/BB
#sudo gdrive update -r -p 1sscS0H_MzZP9nvBMQ3cUpoIug5aNDDCY /mnt/HDD/HACK/bashbunny-payloads/
sudo rclone delete -v Gdrive:HACK/BB  | parallel -Jcluster
sudo rclone copy -v /mnt/HDD/HACK/BB  Gdrive:HACK/BB | parallel -Jcluster
else
echo no changes
  # No changes
fi

cd /mnt/HDD/HACK/TURTLE
git clone --recurse-submodules -j8 ./ | parallel -Jcluster
git commit -m "$(date)" | parallel -Jcluster
sudo echo 3 > /proc/sys/vm/drop_caches
sudo echo 2 > /proc/sys/vm/drop_caches
sudo echo 1 > /proc/sys/vm/drop_caches

if [[ `git status --porcelain` ]]; then
  # Changes
echo changes
git push | parallel -Jcluster
cd /mnt/HDD/HACK/TURTLE
#sudo gdrive update -r -p 1sscS0H_MzZP9nvBMQ3cUpoIug5aNDDCY /mnt/HDD/HACK/bashbunny-payloads/
sudo rclone delete -v Gdrive:HACK/TURTLE  | parallel -Jcluster
sudo rclone copy -v /mnt/HDD/HACK/TURTLE  Gdrive:HACK/TURLE | parallel -Jcluster
sudo echo 3 > /proc/sys/vm/drop_caches
sudo echo 2 > /proc/sys/vm/drop_caches
sudo echo 1 > /proc/sys/vm/drop_caches

else
echo no changes
  # No changes
fi
