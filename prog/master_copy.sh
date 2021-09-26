#!/bin/bash
source $PROG/all-scripts-exports.sh
src="$1"
dest="$2"
type="$3"

private_key=$HOME/.ssh/google_compute_engine
PERONAL_USR=charlieporth1_gmail_com

GCP_SUBNET_1=`ip_exists 10.128.0.9`
GCP_SUBNET_2=`ip_exists 192.168.99.9`

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
default_scp_opt="-T -c $ssh_encryption -o Compression=no -o ControlMaster=auto -o 'ControlPath=~/.ssh/control-%r@%h:%p' -o ControlPersist=30m"
default_scp_opt_w_key="-i $private_key $default_scp_opt"
default_ssh_opt="-x $default_scp_opt"
default_ssh_opt_w_key="-i $private_key $default_ssh_opt"
# tar cf - . | pv | (cd /dst; tar xf -)
# tar zcf - bigfile.m4p | mbuffer -s 1K -m 512 | ssh otherhost "tar zxf -"
if [[ "$type" != '--scp-only' ]] && [[ `command -v rsync` ]] && [[ -f $private_key ]] || [[ "$type" == '--rsync-only' ]]; then
	sudo rsync \
		--rsh="ssh -p22 $default_ssh_opt_w_key" \
		$PERONAL_USR@$HOST:$src $dest \
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
		--human-readable

	if [[ "$type" == '--important' ]] || [[ "$type" == '--scp-too' ]]; then
		sudo gcloud compute scp $MASTER_MACHINE:$src $dest \
			--scp-flag="-r $default_scp_opt" --project "$GCLOUD_PROJECT" --zone "$GCLOUD_ZONE" $internal_ip
	fi
elif [[ "$type" != '--scp-only' ]] && [[ `command -v mbuffer` ]] && [[ -f $private_key ]] || [[ "$type" == '--mbuffer-only' ]]; then
	ssh $default_ssh_opt_w_key $PERONAL_USR@$HOST tar zcf - $src | mbuffer -s 1K -m 512 | "tar zxf -"

	if [[ -d $dest ]]; then
		cd $dest
	else
		cd $(dirname $dest)
	fi
else
	if [[ "$type" != '--rsync-only' ]]; then
		sudo gcloud compute scp $MASTER_MACHINE:$src $dest \
			--scp-flag="-r $default_scp_opt" --project "$GCLOUD_PROJECT" --zone "$GCLOUD_ZONE" $internal_ip
	fi
fi

