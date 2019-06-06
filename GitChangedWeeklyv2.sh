#!/usr/bin/parallel --shebang-wrap --pipe /bin/bash
root=/mnt/HDD/HACK/
function pullGit() {
	fullDir=$1
	cd $dir
	dir=`echo $fullDir | rev| cut -d '/' -f 1-2 | rev`
	if [[ `git status --porcelain` ]]; then
		  # Changes
		echo changes
		git commit -m "$(date)"
		git pull | parallel #-Jcluster
		sudo echo 3 > /proc/sys/vm/drop_caches
		sudo echo 2 > /proc/sys/vm/drop_caches
		sudo echo 1 > /proc/sys/vm/drop_caches
		#sudo git remote -v update
		cd $root
		#sudo gdrive update -r -p 1sscS0H_MzZP9nvBMQ3cUpoIug5aNDDCY /mnt/HDD/HACK/bashbunny-payloads/
		sudo rclone delete -v Gdrive:$dir  | parallel #-Jcluster
		sudo rclone copy -v $fullDir  Gdrive:HACK/$dir | parallel #-Jcluster
		sudo echo 3 > /proc/sys/vm/drop_caches
		sudo echo 2 > /proc/sys/vm/drop_caches
		sudo echo 1 > /proc/sys/vm/drop_caches
	else
		echo no changes
		  # No changes
	fi
}
pullGit /mnt/HDD/HACK/bashbunny-payloads
pullGit /mnt/HDD/HACK/bashbunny-wiki
pullGit /mnt/HDD/HACK/wifipineapple-modules/
pullGit /mnt/HDD/HACK/wifipineapple-wiki/
pullGit /mnt/HDD/HACK/exploit-database/
pullGit /mnt/HDD/HACK/expoit-database-papers
pullGit /mnt/HDD/HACK//exploit-database-bin-sploits/

function pullGitToGit() {
	fullDir=$1
	 dir=`echo $fullDir | rev| cut -d '/' -f 1-2 | rev`
	if [[ `git status --porcelain` ]]; then
		  # Changes
		echo changes
		git commit -m "$(date)"
		git pull | parallel #-Jcluster
		sudo echo 3 > /proc/sys/vm/drop_caches
		sudo echo 2 > /proc/sys/vm/drop_caches
		sudo echo 1 > /proc/sys/vm/drop_caches
		cd $fullDir
		git clone --recurse-submodules -j8 ./ | parallel #-Jcluster
		git add . | parallel #-Jcluster
		git commit -m "$(date)" | parallel #-Jcluster
		sudo echo 3 > /proc/sys/vm/drop_caches
		sudo echo 2 > /proc/sys/vm/drop_caches
		sudo echo 1 > /proc/sys/vm/drop_caches
	
		if [[ `git status --porcelain` ]]; then
			  # Changes
			echo changes
			git push | parallel #-Jcluster
			cd $fullDir
			#sudo gdrive update -r -p 1sscS0H_MzZP9nvBMQ3cUpoIug5aNDDCY /mnt/HDD/HACK/bashbunny-payloads/
			sudo rclone delete -v Gdrive:HACK/$dir  | parallel #-Jcluster
			sudo rclone copy -v $fullDir  Gdrive:HACK/$dir| parallel #-Jcluster
			sudo echo 3 > /proc/sys/vm/drop_caches
			sudo echo 2 > /proc/sys/vm/drop_caches
			sudo echo 1 > /proc/sys/vm/drop_caches
		else
			echo no changes
		  # No changes
		fi
}
pullGitToGit /mnt/HDD/HACK/PINEAPPLE
pullGitToGit /mnt/HDD/HACK/BB
pullGitToGit /mnt/HDD/HACK/TURTLE

