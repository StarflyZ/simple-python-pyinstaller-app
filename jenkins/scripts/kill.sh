#!/usr/bin/env sh

echo 'Stopping the Python executable...'

if [ -f .pidfile ]; then
    set -x
    kill $(cat .pidfile)
    rm .pidfile
    set +x
    echo 'Application has been stopped.'
else
    echo 'No running application found.'
fi
