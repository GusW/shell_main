#!/bin/bash

gitUsername="Gustavo Watanabe"
userEmail="gustavo.watanabe@gmail.com"

apt-get update
apt-get install terminator -y
apt-get install vim -y
apt-get install tree -y
apt-get install gimp -y
apt-get install sshpass -y
apt-get install gparted -y
apt-get install gedit -y

# python dependencies
apt install python-pip python3-pip -y
pip install --upgrade pip
apt-get install virtualenv -y

apt-get install golang-go -y
apt-get install meld -y

apt-get install git -y
git config --global user.name $gitUsername
git config --global user.email $userEmail

add-apt-repository ppa:fish-shell/release-3 # fish shell
add-apt-repository ppa:gezakovacs/ppa       # unetbootin
apt-get update
apt-get install fish -y
apt-get install unetbootin -y

# Docker
apt-get install \
apt-transport-https \
ca-certificates \
curl \
gnupg-agent \
software-properties-common -y
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
apt-key fingerprint 0EBFCD88
add-apt-repository \
"deb [arch=amd64] https://download.docker.com/linux/ubuntu \
bionic \
stable"
apt-get update
apt-get install docker-ce docker-ce-cli containerd.io -y
# Docker images
docker pull postgres # https://hub.docker.com/_/postgres

# generate SSH Keys
ssh-keygen -t rsa -C $userEmail
chmod 0700 ~/.ssh
chmod 0600 ~/.ssh/id_rsa
chmod 0644 ~/.ssh/id_rsa.pub

echo "alias lt='ls --human-readable --size -1 -S --classify'" >> ~/.bash_aliases

# multi-touch
mkdir -p ~/apps && cd "$_"
apt-get install xdotool wmctrl libinput-tools -y
git clone http://github.com/bulletmark/libinput-gestures
cd libinput-gestures
make install #./libinput-gestures-setup install
touch ~/.config/libinput-gestures.conf
echo "gesture swipe up 3 xdotool key ctrl+alt+Up" > ~/.config/libinput-gestures.conf
echo "gesture swipe right 3 xdotool key ctrl+alt+Right" >> ~/.config/libinput-gestures.conf
echo "gesture swipe left 3 xdotool key ctrl+alt+Left" >> ~/.config/libinput-gestures.conf

libinput-gestures-setup autostart
libinput-gestures-setup restart
gpasswd -a $USER input
echo "***** LOG OUT AND IN AGAIN *****"

############################################ apps

# https://pencil.evolus.vn/Downloads.html
# https://code.visualstudio.com/
# https://www.postman.com/downloads/
# https://www.4kdownload.com/downloads

