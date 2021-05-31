#!/bin/bash
SCRIPT_DIR=`realpath .`
ROOT_DIR=$SCRIPT_DIR/..
cd $ROOT_DIR
bash $ROOT_DIR/update.sh --automatic --no-restart --only-apply-config
