#!/bin/bash
SCRIPT_DIR=`realpath .`
ROOT_DIR=$SCRIPT_DIR/..
cd $ROOT_DIR
bash $ROOT_DIR/install.sh --automatic --no-restart --only-apply-config

