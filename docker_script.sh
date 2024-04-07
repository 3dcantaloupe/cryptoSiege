#!/bin/bash
# file:

apt update
apt install neofetch
neofetch
apt install git
git clone https://github.com/twseptian/python-exploit-scripts.git
apt install vim

mkdir tarballs
cd tarballs/
apt install nala
nala install curl
curl -O https://archive.apache.org/dist/httpd/httpd-2.4.49.tar.gz
tar -xzf httpd-2.4.49.tar.gz
cd httpd-2.4.49
apt-get install libpcre3 libpcre3-dev
./configure --prefix=/home/tarballs/httpd-2.4.49/PREFIX
apt-get install build-essential
make 
make install
nala install netcat
nala install net-tools
nala install iputils-ping
nc -l -p 25565

