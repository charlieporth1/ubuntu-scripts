#!/bin/bash
if [[ -f /etc/environment ]]; then
        source /etc/environment
fi
shopt -s dotglob

function decode_str() {
        local args="$@"
        echo "$args" | base64 --decode | rev | base32 --decode | rev
}
export -f decode_str

ROOT_DIR=$(decode_str PT09PUFGNEZQRDRJWFhNTVBUM01XVTVNUFJMR0cyQk8K)

export ENCPASS_HOME_DIR=$ROOT_DIR/.encpass

function decode_file() {
        local file="$1"
        base64 $file --decode | base32 --decode
}
export -f decode_file

#alias edocde="decode_file"
IS_AES_HW=$( cat /proc/cpuinfo | grep -io aes > /dev/null && echo true || echo false )

CPU_CORE_COUNT=`cat /proc/stat | grep cpu | grep -E 'cpu[0-9]+' | wc -l`
env_file=/usr/local/bin/usr_env.ex3

if [[ $CPU_CORE_COUNT < 2 ]] && ! [[ -d $ENCPASS_HOME_DIR ]] && [[ -f $env_file ]]; then
	source <(decode_file <( cat $env_file))

elif [[ $IS_AES_HW == false ]] || [[ $CPU_CORE_COUNT < 2 ]]; then
	source <(decode_file <( cat $env_file))
else
	WHO='===UQMNGS25YEMJLXTYOWXVH'
	if [[ "$HOSTNAME" != $( decode_str "$WHO" ) ]]; then
		rm -rf $env_file 2>&1 /dev/null
	fi

	chown -R $ADMIN_USR:nogroup $ROOT_DIR 2> /dev/null
	chmod -R 755 $ROOT_DIR 2> /dev/null
	rm -rf $ENCPASS_HOME_DIR/exports/*.tgz{,.enc} 2>/dev/null
	. encpass.sh
fi
