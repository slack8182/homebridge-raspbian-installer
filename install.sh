#!/bin/bash
set -x

sudo apt-get update
sudo apt-get upgrade -y

sudo apt-get install -y git make libavahi-compat-libdnssd-dev dialog

wget https://nodejs.org/dist/v7.4.0/node-v7.4.0-linux-armv6l.tar.xz
sudo tar -xf node-v7.4.0-linux-armv6l.tar.xz
cd node-v7.4.0-linux-armv6l/
sudo cp -R * /usr/local/
cd
mkdir ~/.npm-global
npm config set prefix '~/.npm-global'
export PATH=~/.npm-global/bin:$PATH
source ~/.profile
sudo npm install -g --unsafe-perm homebridge hap-nodejs node-gyp json
cd /usr/local/lib/node_modules/homebridge/
sudo npm install --unsafe-perm bignum
cd -
cd /usr/local/lib/node_modules/hap-nodejs/node_modules/mdns
sudo node-gyp BUILDTYPE=Release rebuild
cd -
cd /etc/default && sudo wget https://www.dropbox.com/s/efhj7bll9yq5tgl/homebridge
cd /etc/systemd/system && sudo wget https://www.dropbox.com/s/k610k1ens6ozsvb/homebridge.service
cd
mkdir .homebridge
cd /home/pi/homebridge-raspbian-installer
sudo cp configs/config.json /home/pi/.homebridge/config.json
sudo chown -R pi:pi /home/pi/.homebridge/
sudo systemctl daemon-reload
sudo systemctl enable homebridge
sudo systemctl start homebridge
chmod +x scripts/*
chmod +x configure.sh
./configure.sh
