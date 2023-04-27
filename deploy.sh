#!/bin/bash
pkill -f puma
sudo systemctl start mongod
sudo systemctl enable mongod
sudo systemctl status mongod
sudo apt-get install -y git
git clone -b monolith https://github.com/express42/reddit.git
cd reddit
bundle install
puma -d
