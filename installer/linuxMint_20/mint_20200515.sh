#!/bin/bash

# UPDATED 2020-11-22

################################################################################################################### GIT

gitUsername="Gustavo Watanabe"
userEmail="gustavo.watanabe@gmail.com"

apt-get install git -y
git config --global user.name $gitUsername
git config --global user.email $userEmail

################################################################################################################ SYSTEM

add-apt-repository ppa:fish-shell/release-3
add-apt-repository ppa:alessandro-strada/ppa
apt-add-repository ppa:remmina-ppa-team/remmina-next
apt-get update
apt-get install htop -y
apt-get install vim -y
apt-get install tree -y
apt-get install terminator -y
apt-get install sshpass -y
apt-get install fish -y
apt install google-drive-ocamlfuse -y
apt install remmina remmina-plugin-rdp remmina-plugin-secret -y
echo "alias lt='ls --human-readable --size -1 -S --classify'" >> ~/.bash_aliases
mkdir -p ~/GoogleDrive
google-drive-ocamlfuse
google-drive-ocamlfuse ~/GoogleDrive

########################################################################################################## DESKTOP APPS

apt-get install gparted -y
apt-get install gimp -y
apt-get install vlc -y

# using xed instead
# apt-get install gedit -y

# USB Image Writer instead
# add-apt-repository ppa:gezakovacs/ppa       # unetbootin
# apt-get install unetbootin -y

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
echo "gesture swipe right 4 xdotool key alt+super+Right" >> ~/.config/libinput-gestures.conf
echo "gesture swipe left 4 xdotool key alt+super+Left" >> ~/.config/libinput-gestures.conf

libinput-gestures-setup autostart
libinput-gestures-setup restart
gpasswd -a $USER input
echo "***** LOG OUT AND IN AGAIN *****"

########################################################################################################### PROGRAMMING

# python dependencies
apt install python3-pip -y
apt install libpq-dev python3-dev
pip3 install --upgrade pip
pip3 install --upgrade setuptools
apt install virtualenv -y
apt install python3-venv
apt install -y make build-essential libssl-dev zlib1g-dev \
libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev \
libncursesw5-dev xz-utils tk-dev libffi-dev liblzma-dev python-openssl

curl https://pyenv.run | bash

# pyenv install --list
# pyenv install v <aVersion>
# pyenv global <aVersion>
# python -m test

apt-get install meld -y

apt-get install golang-go -y

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

# Terraform
# https://www.terraform.io/downloads.html
# unzip terraform
# mv terraform ~/.local/bin

# Ansible
apt install ansible -y

# generate SSH Keys
ssh-keygen -t rsa -C $userEmail
chmod 0700 ~/.ssh
chmod 0600 ~/.ssh/id_rsa
chmod 0644 ~/.ssh/id_rsa.pub

# install jvm only!!!
# https://www.java.com/en/download/linux_manual.jsp
# mv Downloads/jre-8u251-linux-x64.tar.gz /usr/lib/jvm/
# cd /usr/lib/jvm/
# tar zxvf /usr/lib/jvm/jre-8u251-linux-x64.tar.gz
# rm /usr/lib/jvm/jre-8u251-linux-x64.tar.gz
# update-alternatives --install "/usr/bin/java" "java" "/usr/bin/jvm/jre1.8.0_251/bin/java" 1
# update-alternatives --set java /usr/bin/jvm/jre1.8.0_251/bin/java
# java -version

# NodeJS & npm
# curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash -
# sudo apt install nodejs

# AWS SHELL CLI
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install

# AWS ELASTIC BEANSTALK SHELL CLI
https://github.com/aws/aws-elastic-beanstalk-cli-setup

# RDESKTOP
apt install libx11-dev -y
apt install libxcursor-dev -y
apt install libtasn1-6-dev -y
apt install nettle-dev -y
apt install gnutls-dev -y
# https://github.com/rdesktop/rdesktop/releases/tag/v1.9.0
# ./configure --disable-credssp --disable-smartcard
# make
# make install
# rdesktop -u <username> <hostname>


#################### ~/.gitconfig
[user]
        email = gustavo.watanabe@gmail.com
        name = Gustavo Watanabe

[core]
        editor = vim
        pager = less -r
        excludesfile = /home/gusw/Documents/code/.gitignore_global

[push]
        default = simple

[color]
        diff = auto
        status = auto
        branch = auto

[pretty]
        graph = %C(green)%h %C(auto)%d %C(reset)%s %C(blue)%an%C(reset) %C(cyan)(%ar)%C(reset)
        log = %C(green)%h %C(reset)%ad %C(auto)%d %C(reset)%s %C(blue)%an%C(reset)

[alias]
        s = status --short --branch
        a = !git add -A && git status --short --branch
        b = branch --verbose
        d = diff
        c = commit
        ae = commit --amend
        an = commit --amend --no-edit
        co = checkout
        rb = rebase
        rbc = rebase --continue
        ch = cherry-pick
        fm = "!f() { git log --pretty=log --date=short --grep=$1; }; f"
        m = merge --no-ff

        wip = "!f() { git add -A; git commit -m \"WIP\"; }; f"
        cnow = "!f() { git add -A; git commit -m \"`date +%Y-%m-%dT%H:%M`\"; git pull --rebase; git push; }; f"

        l = log --graph --pretty=graph --all
        lnp = !git --no-pager log --graph --pretty=graph --all

        alias = !git config --list | grep 'alias\\.' | sed 's/alias\\.\\([^=]*\\)=\\(.*\\)/\\1\\\t -> \\2/'

        # Loads ~/.gitconfig_local.
        # Local definition overwrites the ones above.
        [include]
                path=~/.gitconfig_local
        [diff]
                tool = meld


#################### Visual Studio Code
https://code.visualstudio.com/


#################### ~/.config/Code/User/settings.json

{
    "diffEditor.renderSideBySide": false,

    "editor.fontSize": 10,
    "editor.rulers": [119],
    "editor.renderIndentGuides": false,
    "editor.renderWhitespace": "all",
    "editor.wordWrap": "off",
    "editor.wordBasedSuggestions": false,

    "files.insertFinalNewline": true,
    "files.trimTrailingWhitespace": true,
    "files.autoSave": "off",
    "files.exclude": {
        "**/.git": true,
        "**/*.pyc": true,
        "**/__pycache__": true,
        "**/.cache": true
    },
    "search.exclude": {
        "**/.venv": true,
        "**/.git": true,
        "**/*.pyc": true,
        "**/__pycache__": true,
        "**/.cache": true,
        "tags": true
    },

    "python.linting.pylintEnabled": false,
    "python.linting.flake8Enabled": true,
    "python.linting.flake8Args": [
        "--max-line-length=120"
    ],

    "workbench.editor.enablePreview": true,
    "workbench.activityBar.visible": true,

    "window.zoomLevel": 0,
    "window.menuBarVisibility": "toggle",
    "vsicons.projectDetection.disableDetect": true,
    "workbench.iconTheme": "vscode-icons",
    "workbench.colorTheme": "Atom One Dark",

    "editor.minimap.enabled": true,
    "editor.minimap.renderCharacters": false,

    "keyboard.dispatch": "keyCode",
    "git.enableSmartCommit": true,
    "indenticator.style": "solid",
    "[html]": {
        "editor.tabSize": 2
    },
    "[javascript]": {
        "editor.tabSize": 2
    },
    "[css]": {
        "editor.tabSize": 2
    },
    "workbench.startupEditor": "newUntitledFile",
    "editor.formatOnPaste": false,
    "emmet.triggerExpansionOnTab": true,
    "extensions.ignoreRecommendations": false,
    "gitlens.advanced.messages": {
        "suppressCommitHasNoPreviousCommitWarning": false,
        "suppressCommitNotFoundWarning": false,
        "suppressFileNotUnderSourceControlWarning": false,
        "suppressGitVersionWarning": false,
        "suppressLineUncommittedWarning": false,
        "suppressNoRepositoryWarning": false,
        "suppressUpdateNotice": false,
        "suppressWelcomeNotice": true
    },
    "telemetry.enableTelemetry": false,
    "gitlens.advanced.telemetry.enabled": false,
    "gitlens.codeLens.enabled": false,
    "git.autofetch": true,
    "python.disablePromptForFeatures": [
        "flake8"
    ]
}


#######################################################################################################################
#################### DESKTOP APPS

# Software Manager
chromium 
stacer
vlc
gimp
notepadqq
ulauncher

# Web
https://www.4kdownload.com/downloads
https://pencil.evolus.vn/Downloads.html

https://www.virtualbox.org/wiki/Linux_Downloads
https://download.virtualbox.org/virtualbox/6.1.8/Oracle_VM_VirtualBox_Extension_Pack-6.1.8.vbox-extpack


touch ~/.local/share/applications/firefox.desktop
# [Desktop Entry]
# Version=76.0
# Type=Application
# Name=Firefox Dev
# Exec=/home/gusw/apps/firefox/firefox
# Icon=/home/gusw/app/firefox/browser/chrome/icons/default/default128.png

https://www.postman.com/downloads/
touch ~/.local/share/applications/postman.desktop
#[Desktop Entry]
#Version=7.27.1
#Type=Application
#Name=Postman
#Exec=/home/gusw/app/Postman/app/Postman
#Icon=/home/gusw/app/Postman/app/resources/app/assets/icon.png

#######################################################################################################################
#################### WORK APPS

# https://zoom.us/download
# https://www.citrix.com/downloads/workspace-app/linux/workspace-app-for-linux-latest.html
## cp <MyWorkspace.cert> /opt/Citrix/ICAClient/keystore/cacerts
## sudo /opt/Citrix/ICAClient/util/ctx_rehash
