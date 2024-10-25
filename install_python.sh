#!/usr/bin/bash


install_python () {
  mkdir -p /tmp/build-python-$2
  cd /tmp/build-python-$2
  curl $1 -o /tmp/python.tar.xz
  tar -xf /tmp/python.tar.xz
  cd Python-3*
  ./configure --enable-optimizations
  make -j
  sudo make $3
  cd /tmp
  sudo rm -rf /tmp/build-python-$2
  python$2 --version
  curl -sS https://bootstrap.pypa.io/get-pip.py | python$2
  python$2 -m pip install virtualenv pytest coverage unittest2 pytest-cov tox
}

install_python https://www.python.org/ftp/python/3.8.20/Python-3.8.20.tar.xz 3.8 install 
install_python https://www.python.org/ftp/python/3.9.20/Python-3.9.20.tar.xz 3.9 altinstall
install_python https://www.python.org/ftp/python/3.10.15/Python-3.10.15.tar.xz 3.10 altinstall
install_python https://www.python.org/ftp/python/3.11.10/Python-3.11.10.tar.xz 3.11 altinstall
install_python https://www.python.org/ftp/python/3.12.7/Python-3.12.7.tar.xz 3.12 altinstall
install_python https://www.python.org/ftp/python/3.13.0/Python-3.13.0.tar.xz 3.13 altinstall

curl -sS https://bootstrap.pypa.io/get-pip.py | python3.8

