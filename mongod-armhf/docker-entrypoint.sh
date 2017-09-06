#!/bin/bash

set -e

# if command starts with an option, prepend mongod
if [ "${1:0:1}" = '-' ]; then
	set -- mongod "$@"
fi

if [ "${1}" = "mongod" ]; then
    echo "Starting mongodb..."

    if [ -s "/var/lib/mongodb/mongod.lock" ]; then
        echo "Recovering from unclean shutdown..."

        echo "Creating backup..."
        mkdir -p /var/lib/mongodb.backup
        cp -rf /var/lib/mongodb/* /var/lib/mongodb.backup/

        echo "Running recovery..."
        mongod --dbpath /var/lib/mongodb --repair
    fi

    if [ "$(id -u)" = '0' ]; then
        echo "Executing as user: mongo"
        exec gosu mongo "$@"
    fi
else
    echo "Starting custom command: $@"
fi

exec "$@"