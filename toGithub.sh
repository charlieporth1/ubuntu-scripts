#!/bin/bash
export work=/mnt/HDD/workspace/
export LD_PRELOAD=$LD_PRELOAD:/usr/local/bin/gitbslr.so 
DAY=$(date -d "$D" '+%d')
MONTH=$(date -d "$D" '+%m')
YEAR=$(date -d "$D" '+%Y')
function addSubmoduleR() {
	for d in `ls -d */`
	do
	    pushd $d
	    cd $d
	    pwd
	    export url=$(git config --get remote.origin.url)
	    popd
	    git submodule add $url $d
	done
}
function gitBefore() {
{
	git submodule deinit -f --all
	git rm -r --cached .git/ 
	git rm -r --cached *.git/
	git ignore ".git/"
	git ignore "*.git/"
	git ignore ".git/*"
	git ignore "*.git/*"
	addSubmoduleR
	if [ $DAY == 29 ]; then 
		echo "remove cache day"
		git rm -rf --cached ./
		git add .
		addSubmoduleR
	else 
		echo "not remove cache day"
	fi
	git submodule deinit -f --all
} || {
	echo "error"
}
}
function toGit() {
{
	dir=$1
	cd $dir
	pwd
	ifClus=true
	if [[ $ifClus == true ]]; then
		cluster='-j+64'
	else 
		cluster='-Jcluster'
	fi
	if [[ -f $dir/.git/index.lock ]];then
		rm $dir/.git/index.lock
	fi
	gitBefore
	sleep 5s
	git add .
	addSubmoduleR
	git submodule deinit -f --all
	if [[ `git status --porcelain` ]]; then
	  # Changes
		echo "changes"
		gitBefore
		sleep 5s
		git add  . #| parallel $cluster
		git submodule deinit -f --all
		git commit -m "$(date)" #| parallel $cluster
		#git rm --cached email-virus-report.sh
		#git rm --cached .sh 
		git push #| parallel $cluster
		echo "push complete"
	else
		echo "no changes"
 	 # No changes
	fi
	sleep 3s
} || {
	echo "error toGit failed" 
}
}
function marketing_special() {
	ln -s $work/Google* $work/MARKETING/
}
toGit /mnt/HDD/Programs/
toGit /var/www/
toGit /var/www/SMSCOMMANDS/
marketing_special
toGit /mnt/HDD/workspace/MARKETING/
toGit /mnt/HDD/ApplePaymentsSpoofing
toGit /mnt/HDD/HACK/BB
toGit /mnt/HDD/HACK/TURTLE
toGit /mnt/HDD/HACK/TURTLE
toGit /mnt/HDD/HACK/PINEAPPLE
exit 0

