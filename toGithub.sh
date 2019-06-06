 #!/bin/bash
export work=/mnt/HDD/workspace/
export LD_PRELOAD=$LD_PRELOAD:/usr/local/bin/gitbslr.so 
function gitIgnore() {
	git rm -r --cached .git/ 
	git rm -r --cached *.git/
	git ignore ".git/"
	git ignore "*.git/"
	git ignore ".git/*"
	git ignore "*.git/*"
}
function toGit() {
	dir=$1
	cd $dir
	ifClus=true
	if [[ $ifClus == true ]]; then
		cluster='-j+64'
	else 
		cluster='-Jcluster'
	fi
	if [[ -f $dir/.git/index.lock ]];then
		rm $dir/.git/index.lock
	fi
	gitIgnore
	git submodule deinit --all
	sleep 5s
	git add .
	if [[ `git status --porcelain` ]]; then
	  # Changes
		echo "changes"
		gitIgnore
		git submodule deinit --all
		sleep 5s
		git add  . #| parallel $cluster
		git commit -m "$(date)" #| parallel $cluster
		git rm --cached -r .git #| parallel $cluster
		#git rm --cached email-virus-report.sh
		#git rm --cached .sh 
		git push #| parallel $cluster
		echo "push complete"
	else
		echo "no changes"
 	 # No changes
	fi
	sleep 3s
}
function marketing_special() {
	ln -s $work/Google* $work/MARKETING/
}
toGit /mnt/HDD/Programs/
toGit /var/www/
toGit /var/www/SMSCOMMANDS/
toGit /mnt/HDD/HACK/BB
toGit /mnt/HDD/HACK/TURTLE
toGit /mnt/HDD/HACK/TURTLE
toGit /mnt/HDD/HACK/PINEAPPLE
marketing_special
toGit /mnt/HDD/workspace/MARKETING/
toGit /mnt/HDD/ApplePaymentSpoofing
exit 0

