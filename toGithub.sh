#!/bin/bash

cd /mnt/HDD/Programs/
git add .
if [[ `git status --porcelain` ]]; then
  # Changes
echo changes
git add .
git commit -m "$(date)"
git config --global credential.helper
git rm --cached -r .git
#git rm --cached email-virus-report.sh
git rm --cached FirebaseNewUsercheck.sh 
#git rm --cached .sh 
git push | parallel -j128 -Jcluster

else
echo no changes
  # No changes
fi

cd /var/www/
git add .
if [[ `git status --porcelain` ]]; then
  # Changes
echo changes
git add .
git commit -m "$(date)"
git rm --cached -r .git
#git rm --cached email-virus-report.sh
#git rm --cached FirebaseNewUsercheck.sh 
#git rm --cached .sh 
git push | parallel -j128 -Jcluster

else
echo no changes
  # No changes
fi

cd /var/www/SMSCOMMANDS/
git add .
if [[ `git status --porcelain` ]]; then
  # Changes
echo changes
git add .
git commit -m "$(date)"
git config --global credential.helper
git rm --cached -r .git
#git rm --cached email-virus-report.sh
#git rm --cached .sh 
git push | parallel -j128 -Jcluster

else
echo no changes
  # No changes
fi
