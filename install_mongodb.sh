#!/bin/sh
sudo apt-get install -y apt-transport-https ca-certificates
wget -qO - https://www.mongodb.org/static/pgp/server-4.2.asc | sudo apt-key add -
echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/4.2 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.2.list
sudo apt-get update
sudo apt-get install -y mongodb-org
sudo systemctl enable mongod
sudo systemctl start mongod

sudo systemctl enable mongodb
sudo systemctl start mongodb

# 8 errors:...
#
##!/bin/bash
#
#sudo apt-get install -y apt-transport-https ca-certificates
#wget -qO - https://www.mongodb.org/static/pgp/server-4.2.asc | sudo apt-key add -
#echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu xenial/mongodborg/4.2 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.2.list
##echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/5.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-5.0.list
#sudo apt update
#sudo apt-get install -y mongodb-org
#sudo apt-get install -y mongodb
#
#sudo systemctl enable mongod
#sudo systemctl start mongod
#sudo systemctl enable mongodb
#sudo systemctl start mongodb
