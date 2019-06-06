#!/bin/bash
export per=$(df | grep "/tmp" | awk '{print $5}' | cut -d "%" -f 1)
export perFull=85
if [[ $per > $perFull ]]; then
	echo "cleanning"
	rm -rf /tmp/*
	echo "done"
	sleep 10s
	if [[ $per > $perFull ]]; then
		cd /tmp/
		for pid in $(sudo lsof | egrep '^COMMAND|deleted' | awk '{print $2}')
		do
			sudo kill -9 $pid 1> /dev/null
			sudo kill -8 $pid 1> /dev/null
			sudo kill -7 $pid 1> /dev/null
			echo "killed $pid"
		done
	echo "done killing"
	fi
else
	echo "limit $perFull; not at percent its at $per; "
fi

