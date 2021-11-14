#!/bin/bash
shopt -s dotglob
ROOT_DIR=/opt/config/.ctp
export ENCPASS_HOME_DIR=$ROOT_DIR/.encpass
chown -R $ADMIN_USR:nogroup $ROOT_DIR 2> /dev/null
chmod -R 755 $ROOT_DIR 2> /dev/null
rm -rf $ENCPASS_HOME_DIR/exports/*.tgz{,.enc} 2>/dev/null
. encpass.sh
