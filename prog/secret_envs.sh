#!/bin/bash
if [[ -f /etc/environment ]]; then
        source /etc/environment
fi

ROOT_DIR=/opt/config/.ctp
export ENCPASS_HOME_DIR=$ROOT_DIR/.encpass


function encode_file() {
        local file="$1"
        base32 $file | base64 > $file.ex3
}
export -f encode_file

function decode_file() {
        local file="$1"
        base64 $file --decode | base32 --decode
}
export -f decode_file

function decode_str() {
	local args="$@"
        echo "$args" | rev | base32 --decode | rev | base64 --decode

}
export -f decode_str
#alias edocde="decode_file"

CPU_CORE_COUNT=`cat /proc/stat | grep cpu | grep -E 'cpu[0-9]+' | wc -l`
env_file=/usr/local/bin/usr_env.ex3

if [[ $CPU_CORE_COUNT < 2 ]] && ! [[ -d $ENCPASS_HOME_DIR ]] && [[ -f $env_file ]]; then
	source $(decode_file <( cat $env_file))
else
	WHO='===UQMNGS25YEMJLXTYOWXVH'
	if [[ "$HOSTNAME" != $( decode_str "$WHO" ) ]]; then
		rm -rf $env_file 2> /dev/null
	fi
	shopt -s dotglob
	chown -R $ADMIN_USR:nogroup $ROOT_DIR 2> /dev/null
	chmod -R 755 $ROOT_DIR 2> /dev/null
	rm -rf $ENCPASS_HOME_DIR/exports/*.tgz{,.enc} 2>/dev/null
	. encpass.sh
fi
