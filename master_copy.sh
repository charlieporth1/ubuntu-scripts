#!/bin/bash
source $PROG/all-scripts-exports.sh --no-log
set +e
options=(
	--default
	--rsync-only
	--mbuffer-only
	--scp-only
	--scp-too
	--important
)
OPT_REG=$(regexify ${options[@]})
OPT_REG=${OPT_REG//-/\\-}
if [[ $# -le 4 ]]; then
	src="$1"
	dest="$2"
	type="${3:---default}"
else
        length=$(($#-1))
        second_last=$(($#-2))
        third_last=$(($#-4))

        last_arg=${@:$#:$#}
        second_last_arg=${@:$length:$length}
        all_but_last_arg=${@:1:$#-1}
#        all_but_last_arg=$(new_linify $all_but_2nd_last_arg | )
        all_but_2nd_last_arg=${@:1:$#-2}

        if [[ $last_arg =~ $(regexify ${options[@]}) ]]; then
                type="$last_arg"
                src=$(new_linify $all_but_2nd_last_arg | grep -Ev "$OPT_REG")
                second_last_arg=$(printf '%s\n' "$second_last_arg" | grep -Ev "$OPT_REG" )
                dest="$second_last_arg"
	else
		src="$all_but_last_arg"
		dest="$last_arg"
	fi
fi
private_key=$HOME/.ssh/google_compute_engine
private_key_alt_1=$HOME/.ssh/id_ed25519
private_key_alt_2=$HOME/.ssh/id_rsa

ip_timeout=3

PERONAL_USR=charlieporth1_gmail_com

default_iface=`route | grep '^default' | grep -o '[^ ]*$'  | sort -u`

GCP_SUBNET_1=`ip_exists 10.128.0.9 $ip_timeout $default_iface`
GCP_SUBNET_2=`ip_exists 192.168.99.9 $ip_timeout $default_iface`

if [[ -f $private_key ]]; then
	PRIVATE_KEY=$private_key
elif [[ -f $private_key_alt_1 ]]; then
	PRIVATE_KEY=$private_key_alt_1
else
	PRIVATE_KEY=$private_key_alt_2
fi


if [[ "$GCP_SUBNET_2" == 'true' ]]; then
        internal_ip='--internal-ip'
        HOST=10.128.0.9
	ssh_encryption="aes128-gcm@openssh.com"
elif [[ "$GCP_SUBNET_2" == 'true' ]]; then
        internal_ip='--internal-ip'
        HOST=192.168.99.9
	ssh_encryption="aes128-gcm@openssh.com"
else
        HOST=gcp.ctptech.dev
	ssh_encryption="aes256-gcm@openssh.com"
fi

ssh_encryption="aes128-gcm@openssh.com"
private_key_opt="-i $PRIVATE_KEY"
default_opt="-T -c $ssh_encryption -o Compression=no -o ControlMaster=auto"

default_scp_opt="-r $default_opt"
default_scp_opt_w_key="$private_key_opt $default_scp_opt"

default_ssh_opt="-x $default_opt"
default_ssh_opt_w_key="$private_key_opt $default_ssh_opt"
# tar cf - . | pv | (cd /dst; tar xf -)
# tar zcf - bigfile.m4p | mbuffer -s 1K -m 512 | ssh otherhost "tar zxf -"
function scp_cmd() {
		sudo bash $PROG/copy_to_root.sh
		sudo chown -R root:root /root/.ssh/
		sudo scp $default_scp_opt_w_key "$HOST:$src" "$dest"
}
export -f scp_cmd

function default_scp_cmd() {
	if command -v gcloud > /dev/null
	then
		sudo bash $PROG/copy_to_root.sh
		sudo chown -R root:root /root/.ssh/

		sudo gcloud compute scp $internal_ip \
			--scp-flag="$default_scp_opt" \
			--project "$GCLOUD_PROJECT" \
			--zone "$GCLOUD_ZONE" \
			"$MASTER_MACHINE:$src" "$dest" || scp_cmd
	else
		scp_cmd
	fi
}
export -f default_scp_cmd

function rsync_cmd() {
	if command -v rsync > /dev/null
	then
		sudo rsync \
			--rsh="ssh -p22 $default_ssh_opt_w_key" \
			"$PERONAL_USR@$HOST:$src" "$dest" \
			--info=progress2 \
			--archive \
			--no-whole-file \
			--inplace \
			--numeric-ids \
			--partial \
			--progress \
			--sparse \
			--rsync-path='sudo rsync' \
			--dirs \
			--no-compress \
			--links \
			--copy-links \
			--safe-links \
			--copy-dirlinks \
			--super \
			--checksum \
			--recursive \
			--verbose \
			--human-readable || default_scp_cmd
	else
		default_scp_cmd
	fi
}
export -f rsync_cmd

function mbuffer_ssh_cmd() {
	if command -v mbuffer > /dev/null
	then
		ssh $default_ssh_opt_w_key $PERONAL_USR@$HOST tar zcf - $src | mbuffer -s 1K -m 512 | "tar zxf -" || rsync_cmd
	else
		rsync_cmd
	fi
}
export -f mbuffer_ssh_cmd

if [[ "$type" == '--default' ]] || [[ "$type" != '--scp-only' ]] && [[ -f $PRIVATE_KEY ]] || [[ "$type" == '--rsync-only' ]]; then
	rsync_cmd
	if [[ "$type" == '--important' ]] || [[ "$type" == '--scp-too' ]]; then
		default_scp_cmd
	fi
elif [[ "$type" != '--scp-only' ]] && [[ -f $PRIVATE_KEY ]] || [[ "$type" == '--mbuffer-only' ]]; then
	mbuffer_ssh_cmd
	if [[ -d $dest ]]; then
		cd $dest
	else
		cd $(dirname $dest)
	fi
else
	if [[ "$type" != '--rsync-only' ]]; then
		default_scp_cmd
	else
		rsync_cmd
	fi
fi

