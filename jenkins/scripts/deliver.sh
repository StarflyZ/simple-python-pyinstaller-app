#!/usr/bin/env sh

echo 'Starting Python application deployment...'

set -x
if [ ! -d "venv" ]; then
    python -m venv venv
fi
. venv/bin/activate
pip install --upgrade pip
pip install -r requirements.txt
set +x

echo 'Running Python application...'
python app.py 2>&1 | tee app.log &
echo $! > .pidfile

echo 'Python application is running! Logs:'
tail -f app.log & 
