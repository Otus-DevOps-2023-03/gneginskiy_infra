#!/bin/bash
#installing ruby
sudo apt update
sudo apt install -y ruby-full ruby-bundler build-essential
#installing and running mongo
wget -qO - https://www.mongodb.org/static/pgp/server-4.2.asc | sudo apt-key add -
echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu xenial/mongodborg/4.2 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.2.list
sudo apt-get update
sudo apt-get install -y mongodb-org
sudo systemctl start mongod
sudo systemctl enable mongod
sudo systemctl status mongod
#installing GIT and deploying the app
pkill -f puma
sudo apt-get install git
git clone -b monolith https://github.com/express42/reddit.git
cd reddit
bundle install
puma -d
