#!/bin/bash

wget https://www.python.org/ftp/python/3.9.18/Python-3.9.18.tgz

tar xvf Python-*.tgz

cd Python-3.9*/

./configure --enable-optimizations --prefix=/usr/local --enable-shared LDFLAGS="-Wl,-rpath /usr/local/lib"

make altinstall

python3.9 --version

pip3.9 --version

/usr/local/bin/python3.9 -m pip install --upgrade pip
