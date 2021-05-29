#!/bin/bash
export work=/mnt/HDD/workspace/
export LD_PRELOAD=$LD_PRELOAD:/usr/local/bin/gitbslr.so 
DAY=$(date -d "$D" '+%d')
MONTH=$(date -d "$D" '+%m')
YEAR=$(date -d "$D" '+%Y')
declare -a ignore=('node_modules/' '*node_modules/' '*/node_modules/' '*/node_modules/*' '*node_modules/*' 'Pods/' 'Pods/*' '*Pods/' '*/Pods/' '*Pods/*'
'*/Pods/*' '.git/' '*.git/' '.git/*' '*.git/*' '*/.git/*' '*/.git/')
function addSubmoduleR() {
	backDir=$1
	for d in `ls -d */`
	do
	if [ -d ./.git ]; then
	    pushd $d
	    cd $d
	    pwd
	    export url=$(git config --get remote.origin.url)
	    echo "dir: $d URL: $url"
#	    popd
	    for ig in ${ignore[@]}; do git ignore "$ig"; done
       	    for rem in ${ignore[@]}; do git rm -r --cached $rem; done
	    git --git-dir=$backDir submodule add -f $url $d #2>&1/dev/null
            cd $backDir
	fi
	done
}
function gitBefore() {
{
	dir=$1
	git submodule deinit -f --all
	for rem in ${ignore[@]}; do git rm -r --cached $rem; done
        for ig in ${ignore[@]}; do git ignore "$ig"; done
	addSubmoduleR  $dir
	if [ $DAY == 29 ]; then 
		echo "remove cache day"
		git rm -rf --cached ./
		git add .
		addSubmoduleR $dir
	else 
		echo "not remove cache day"
	fi
	git submodule deinit -f --all
} || {
	echo "error"
}
}
. /usr/bin/cred.sh
function toGit() { 
{	dir=$1
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
	gitBefore $dir
	sleep 5s
	git add .
	if [[ `git status --porcelain` ]]; then
	  # Changes
		echo "changes"
		gitBefore $dir
		sleep 5s
		git add  . #| parallel $cluster
		git commit -a -m "$(date)" #| parallel $cluster
		#git rm --cached email-virus-report.sh
		#git rm --cached .sh 
	        git push -ff #| parallel $cluster
		echo "push complete"
	else
		echo "no changes"
 	 # No changes
	fi
	sleep 3s
	return
} || {
	echo "error toGit failed" 
	return
}
return
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

