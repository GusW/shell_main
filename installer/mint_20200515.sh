#!/bin/bash

gitUsername="Gustavo Watanabe"
userEmail="gustavo.watanabe@gmail.com"

apt-get update
apt-get install terminator -y
apt-get install vim -y
apt-get install tree -y
apt-get install gimp -y
apt-get install vlc -y
apt-get install sshpass -y
apt-get install gparted -y
apt-get install gedit -y

# python dependencies
apt install python-pip python3-pip -y
apt install libpq-dev python3-dev
pip install --upgrade pip
pip install --upgrade setuptools
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
# Docker compose
curl -L "https://github.com/docker/compose/releases/download/1.25.5/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
docker-compose --version
# Docker images
docker pull postgres # https://hub.docker.com/_/postgres

# Kubernetes (kubectl)
apt-get update && apt-get install -y apt-transport-https gnupg2
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | tee -a /etc/apt/sources.list.d/kubernetes.list
apt-get update && apt-get install -y kubectl
# Minikube
wget https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
chmod +x minikube-linux-amd64
mv minikube-linux-amd64 /usr/local/bin/minikube
# KVM Hypervisor
apt-get -y install qemu-kvm libvirt-bin virt-top  libguestfs-tools virtinst bridge-utils
modprobe vhost_net
lsmod | grep vhost
echo "vhost_net" | tee -a /etc/modules
# docker-kvm-driver
curl -LO https://storage.googleapis.com/minikube/releases/latest/docker-machine-driver-kvm2
chmod +x docker-machine-driver-kvm2
mv docker-machine-driver-kvm2 /usr/local/bin/
docker-machine-driver-kvm2 version
apt install ebtables iptables dnsmasq
systemctl restart libvirtd
minikube config set vm-driver kvm2

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
echo "gesture swipe down 3 xdotool key ctrl+alt+Down" >> ~/.config/libinput-gestures.conf
echo "gesture swipe right 4 xdotool key alt+super+Right" >> ~/.config/libinput-gestures.conf
echo "gesture swipe left 4 xdotool key alt+super+Left" >> ~/.config/libinput-gestures.conf

libinput-gestures-setup autostart
libinput-gestures-setup restart
gpasswd -a $USER input
echo "***** LOG OUT AND IN AGAIN *****"

############################################ apps

# https://www.google.com/intl/en_us/chrome/
# https://www.4kdownload.com/downloads
# https://pencil.evolus.vn/Downloads.html
# https://code.visualstudio.com/
# https://www.postman.com/downloads/
# https://www.virtualbox.org/wiki/Linux_Downloads
# https://download.virtualbox.org/virtualbox/6.1.8/Oracle_VM_VirtualBox_Extension_Pack-6.1.8.vbox-extpack

# https://zoom.us/download
# https://www.citrix.com/downloads/workspace-app/linux/workspace-app-for-linux-latest.html
### cp <MyWorkspace.cert> /opt/Citrix/ICAClient/keystore/cacerts
### sudo /opt/Citrix/ICAClient/util/ctx_rehash


