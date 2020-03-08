#!/bin/bash

gitUsername="GusW"
gitUseremail="gustavo.watanabe@gmail.com"

apt-get update
apt-get install vim -y
apt-get install sshpass -y
apt-get install gawk -y
apt-get install terminator -y
apt-get install virtualenv -y
apt-get install gparted -y
apt-get install mysql-server -y
apt-get install mysql-workbench -y
apt-get install postgresql postgresql-contrib -y
#dependencias
apt-get install python-psycopg2
apt-get install libpq-dev
apt-get install libxml2-dev libxslt-dev python-dev
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

#utilities
#apt-get install gnome-sushi -y

# yandex-disk
# echo "deb http://repo.yandex.ru/yandex-disk/deb/ stable main" | sudo tee -a /etc/apt/sources.list.d/yandex.list > /dev/null && wget http://repo.yandex.ru/yandex-disk/YANDEX-DISK-KEY.GPG -O- | sudo apt-key add - && sudo apt-get update && sudo apt-get install -y yandex-disk

# python linter
apt-get install flake8 -y

# install requirements
#(segurospromo) .../segurospromo $ pip install -r requirements.txt
# sudo su --postgres
# psql
# ALTER USER postgres WITH PASSWORD 'marreta'
# \q
# createdb segurospromo
# psql -U postgres -d segurospromo < dump.file.sql
# python manage.py collectstatic
