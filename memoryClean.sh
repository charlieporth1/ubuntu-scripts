#!/bin/bash
function cleanMemory() {
	sync
	sudo echo 3 > /proc/sys/vm/drop_caches
	sudo echo 2 > /proc/sys/vm/drop_caches
	sudo echo 1 > /proc/sys/vm/drop_caches
	sync
	return
}
export -f cleanMemory
