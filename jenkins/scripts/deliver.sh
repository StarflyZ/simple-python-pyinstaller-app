#!/usr/bin/env sh

echo 'Building standalone executable with PyInstaller...'

set -x
# Buat virtual environment jika belum ada
if [ ! -d "venv" ]; then
    python -m venv venv
fi

# Aktifkan virtual environment
. venv/bin/activate

# Install dependencies
pip install --upgrade pip
pip install pyinstaller

# Build executable dengan PyInstaller
pyinstaller --onefile sources/add2vals.py

set +x

echo 'The executable has been built and is available in the "dist/" directory.'
echo 'You can download it from Jenkins workspace.'

# Jalankan aplikasi sebagai service di background
set -x
./dist/add2vals &  
echo $! > .pidfile
set +x

echo 'Application is running in the background. Waiting for user confirmation before stopping...'
