#!/bin/bash
export totalMemory=$(free | awk '{print $2}'  | sed -n '2p')
export freeMemory=$(free | awk '{print $4}'  | sed -n '2p')
export usedMemory=$(free | awk '{print $3}'  | sed -n '2p')
export avabMemory=$(free | awk '{print $6}'  | sed -n '2p')

export totalSwap=$(free | awk '{print $2}'  | sed -n '3p')
export freeSwap=$(free | awk '{print $4}'  | sed -n '3p')
export usedSwap=$(free | awk '{print $3}'  | sed -n '3p')
export percentFreeLimit=25
if [ totalMemory / freeMemory > percentFreeLimit ]; then
sudo 
fi
