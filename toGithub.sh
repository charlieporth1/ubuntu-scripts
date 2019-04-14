#!/bin/bash

function toGit() {
dir=$1
ifClus=false
if [ $ifClus ]; then
	cluster=
else 
	cluster=-jcluster
fi
cd $dir
if [ -f $dir/.git/index.lock ];then
	rm $dir/.git/index.lock
fi
git add .
if [[ `git status --porcelain` ]]; then
  # Changes
	echo changes
	git add .
	git commit -m "$(date)"
	git rm --cached -r .git
	#git rm --cached email-virus-report.sh
	#git rm --cached .sh 
	git push | parallel 

else
	echo no changes
  # No changes
fi
}
toGit /mnt/HDD/Programs/ 
toGit /var/www/ 
toGit /mnt/HDD/workspace/MARKETING/
exit 0

