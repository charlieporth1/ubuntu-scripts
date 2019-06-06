#!/bin/bash
export PORT=$(( (($RANDOM<<15)|$RANDOM) % 63001 + 2000 ))
echo $PORT 
