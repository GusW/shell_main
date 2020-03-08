#!/bin/bash

gitUsername="GusW"
gitUseremail="gustavo.watanabe@gmail.com"
sudo su
apt-get update
apt-get install vim -y
apt-get install sshpass -y
apt-get install gawk -y
apt-get install mysql-server -y
apt-get install mysql-workbench -y
apt-get install postgresql postgresql-contrib -y
apt-get install pgadmin3 -y
apt-get install git-core -y
#git config --global user.name $gitUsername
#git config --global user.email $gitUseremail
cd /tmp
wget https://atom.io/download/deb -O atom-amd64.deb
dpkg -i atom-amd64.deb
rm atom-amd64.deb
#curl -L -s get.jenv.io | bash
curl https://install.meteor.com/ | sh
