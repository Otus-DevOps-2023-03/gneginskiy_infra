#!/bin/bash
pkill -f puma
sudo apt-get install git
git clone -b monolith https://github.com/express42/reddit.git
cd reddit
bundle install
puma -d
