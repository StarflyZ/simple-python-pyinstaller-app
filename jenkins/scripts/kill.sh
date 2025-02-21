#!/usr/bin/env sh

echo 'Stopping the Python application...'

if [ -f .pidfile ]; then
    set -x
    kill $(cat .pidfile)
    rm .pidfile
    set +x
    echo 'Application has been stopped automatically after 1 minute.'
else
    echo 'No running application found.'
fi
