#!/bin/bash
export per=$(df | grep "/tmp" | awk '{print $5}' | cut -d "%" -f 1)
export  perFull=85
if [[ $per > $perFull ]]; then
echo "cleanning"
 rm -rf /tmp/*
echo "done"
else 
echo "limit $perFull; not at percent its at $per; "
fi

