#!/bin/bash

SCRIPTS_DIR="/opt/sinusbot/scripts"

if [ -d "$SCRIPTS_DIR" ] && [ ! "$(ls -A $SCRIPTS_DIR)" ]; then
    cp -a /opt/sinusbot/scripts.dist/* "$SCRIPTS_DIR/"
fi

exec "$@"
