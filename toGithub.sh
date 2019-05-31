 #!/bin/bash
export work=/mnt/HDD/workspace/
export LD_PRELOAD=$LD_PRELOAD:/usr/local/bin/gitbslr.so 
function gitIgnore() {
	git rm -r --cached ./.git/   
	git ignore ".git/"
	git ignore "*.git/"
	git ignore ".git/*"
	git ignore "./.git/"
	git ignore "./.git/*"
}
function toGit() {
	dir=$1
	ifClus=false
	if [ $ifClus ]; then
		cluster=-j+64
	else 
		cluster=-Jcluster
	fi
	cd $dir
	if [ -f $dir/.git/index.lock ];then
		rm $dir/.git/index.lock
	fi
	gitIgnore
	git add .
	if [[ `git status --porcelain` ]]; then
	  # Changes
		echo changes
		gitIgnore
		git add -f . #| parallel $cluster
		git commit -m "$(date)" #| parallel $cluster
		git rm --cached -r .git #| parallel $cluster
		#git rm --cached email-virus-report.sh
		#git rm --cached .sh 
		git push | parallel $cluster

	else
		echo no changes
 	 # No changes
	fi
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

