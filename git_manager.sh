#!/bin/bash
declare -axg git_dirs
git_dirs=(
        /home/charlieporth1_gmail_com/accomplist/
        $HOLE/
        /etc/

)
function git_cleanup() {
        dir="$1"
        cd $dir
        git gc
}
export -f git_cleanup
function git_pull_update() {
	git pull -ff || git stash && git pull -ff
}
export -f git_pull_update

function git_push_update() {
	git push -ff || git push --set-upstream origin master -ff
}
export -f git_push_update

function if_no_git__init_git() {
        local repo="$1"
	local root_dir="$2"
	cd $root_dir
        if ! [[ -d $root_dir/.git ]]; then
                git init
                git remote add origin $repo
		git add .
		git commit -m "First automatic commit from server at: `date`"
                git pull origin master
                git push --set-upstream origin master
        fi

}
export -f if_no_git__init_git

function if_submodule_add() {
        local ROOT="${1:-$ROOT_GIT_DIR}"
        cd $ROOT
        local submodules_dir=`find $ROOT -type d -name .git | grep -v '\./\.'`
        if [[ -n "$submodules_dir" ]]; then
		IFS=$'\n'
                for submodules_git_dir in ${submodules_dir}
                do
                        git_sub_repo_url=`grep url $submodules_git_dir/config | awk '{print $3}'`
                        git submodule add $git_sub_repo_url $submodules_git_dir
                done
        fi
}
export -f if_submodule_add

function commit_and_push() {
	ROOT_GIT_DIR="${1:-$ROOT_GIT_DIR}"
        echo $ROOT_GIT_DIR
        cd $ROOT_GIT_DIR
       	git_pull_update
        git add . --verbose
        git commit -m "Automatic commit from server at: `date`"
	git_push_update
}
export -f commit_and_push

function copy_git_config() {
	git config --global user.name 'Charlie Porth'
	git config --global user.email 'charlieporth1@gmail.com'
	cp -rf $ADMIN_HOME/.git* $HOME
}
export -f copy_git_config


function run_git_gc_thru_repos() {
	for dir in "${git_dirs[@]}"
	do
		cd $dir
		git_cleanup $dir
	done
}
export -f run_git_gc_thru_repos
