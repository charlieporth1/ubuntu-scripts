#!/bin/bash
ps aux | grep pm.stale-dns-chck.sh | grep -v 'grep' | awk '{print $2}' | xargs sudo kill -9
