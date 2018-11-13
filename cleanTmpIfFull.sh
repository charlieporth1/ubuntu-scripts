#!/bin/bash
export per=$(df | grep "/tmp" | awk '{print $5}')

if [ "$per" == "75%" ]; then
echo "cleanning"
 rm -rf /tmp/*
echo "done"
else 
echo "not at percent its at $per"
fi

