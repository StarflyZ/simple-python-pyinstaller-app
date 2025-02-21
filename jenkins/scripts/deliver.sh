#!/usr/bin/env sh

echo 'Starting Python application deployment...'

set -x
# Membuat virtual environment jika belum ada
if [ ! -d "venv" ]; then
    python -m venv venv
fi

# Aktifkan virtual environment
. venv/bin/activate

# Install dependencies jika ada
pip install --upgrade pip
pip install -r requirements.txt
set +x

echo 'Running Python application...'

# Jalankan aplikasi dengan output ke log & tampilkan di Jenkins
python app.py 2>&1 | tee app.log &

# Simpan PID aplikasi
echo $! > .pidfile

echo 'Python application is running! Logs:'
tail -f app.log &  # Menampilkan log real-time di Jenkins
