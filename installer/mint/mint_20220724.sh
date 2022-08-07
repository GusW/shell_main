#!/bin/bash

# UPDATED 2022-07-24

################################################################################################################### GIT

gitUsername="Gustavo Watanabe"
userEmail="gustavo.watanabe@gmail.com"

apt-get install git -y
git config --global user.name $gitUsername
git config --global user.email $userEmail

################################################################################################################ SYSTEM

inxi -Fxxxz

# NETWORK disconnecting issue
# disable IPv6
iwconfig
sudo iwconfig wlp2s0 power off
sudo service network-manager restart
sudo sed -i 's/3/2/' /etc/NetworkManager/conf.d/default-wifi-powersave-on.conf

lsmod | grep ath
echo "options ath10k_core skip_otp=y" | sudo tee /etc/modprobe.d/ath10k.conf
sudo modprobe ath10k_pci

# reboot

sudo apt install htop -y
sudo apt install vim -y
sudo apt install tree -y
sudo apt install terminator -y
sudo apt install sshpass -y

sudo apt install gparted -y
sudo apt install gimp -y
sudo apt install vlc -y

echo "alias lt='ls --human-readable --size -1 -S --classify'" >> ~/.bash_aliases
echo "alias ll='ls -alh'" >> ~/.bash_aliases
source ~/.bash_aliases

# multi-touch
mkdir -p ~/app && cd "$_"
apt-get install xdotool wmctrl libinput-tools -y
git clone http://github.com/bulletmark/libinput-gestures
cd libinput-gestures
make install #./libinput-gestures-setup install
touch ~/.config/libinput-gestures.conf
echo "gesture swipe up 3 xdotool key ctrl+alt+Up" > ~/.config/libinput-gestures.conf
echo "gesture swipe right 3 xdotool key ctrl+alt+Right" >> ~/.config/libinput-gestures.conf
echo "gesture swipe left 3 xdotool key ctrl+alt+Left" >> ~/.config/libinput-gestures.conf
echo "gesture swipe down 3 xdotool key ctrl+alt+Down" >> ~/.config/libinput-gestures.conf
echo "gesture swipe right 4 xdotool key ctrl+shift+alt+Right" >> ~/.config/libinput-gestures.conf
echo "gesture swipe left 4 xdotool key ctrl+shift+alt+Left" >> ~/.config/libinput-gestures.conf

libinput-gestures-setup autostart
libinput-gestures-setup restart
gpasswd -a $USER input
echo "***** LOG OUT AND IN AGAIN *****"

# nordvpn
# https://nordvpn.com/download/
nordvpn login
# "Open with" popup, and copy the link that is assigned to the "Continue" link,
# under the message saying "You've successfully logged in"
nordvpn login --callback "nordvpn://<link>"

# sirikali
# https://software.opensuse.org//download.html?project=home%3Aobs_mhogomchungu&package=sirikali

########################################################################################################### PROGRAMMING

# PyEnv
apt install -y make build-essential libssl-dev zlib1g-dev \
libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev \
libncursesw5-dev xz-utils tk-dev libffi-dev liblzma-dev python-openssl

curl https://pyenv.run | bash

# BASH
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc
echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc
echo -e 'if command -v pyenv 1>/dev/null 2>&1; then\n eval "$(pyenv init -)"\nfi' >> ~/.bashrc
exec "#SHELL"

pyenv install --list
pyenv install <aVersion>
pyenv global <aVersion>
python -m test

# python dependencies
apt install python3-pip -y
apt install libpq-dev python3-dev
pip3 install --upgrade pip
pip3 install --upgrade setuptools
apt install virtualenv -y
apt install python3-venv

