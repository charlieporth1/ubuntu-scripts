#!/bin/bash
source /etc/environment
export CTP_LIST=$WWW/txt_lists/ctp-lists
if [[ -d $CTP_LIST ]] && [[ "$HOSTNAME" == 'ctp-vpn' ]]; then
	declare -a domain_lists
	domain_lists=(
		$HOLE/goverment-whitelist.list
		$HOLE/custom-mobile-trackers-blacklist.list
		$HOLE/vulnerability-blacklist.regex

		$HOLE/{hubspot,onedrive,instagram,reddit,speedtests}-whitelist.list
		$HOLE/{samsung,apple,amazon,facebook}-{white,black}list.list

		$HOLE/{snapchat,google}-{white,black}list.{regex,list}
	)

	sudo rsync \
		--archive \
		--no-whole-file \
		--dirs \
		--links \
                --copy-links \
                --safe-links \
                --copy-dirlinks \
                --super \
		--verbose \
                --checksum \
                --recursive \
                --no-compress \
		"${domain_lists[@]}" \
		$CTP_LIST/

	chmod 755 ${domain_lists[@]}

	chmod -R 755 $CTP_LIST/
	chown -R www-data:www-data $CTP_LIST/
	echo "Done coping"
fi
exit 0
