#!/bin/bash

gitUsername="Gustavo Watanabe"
userEmail="gustavo.watanabe@gmail.com"

apt-get update
apt-get install tree -y
apt-get install gnome-system-monitor -y
apt-get install gimp -y
apt-get install vim -y
apt-get install sshpass -y
apt-get install gawk -y
apt-get install terminator -y
apt-get install virtualenv -y
apt-get install gparted -y
apt-get install golang-go -y
apt-get install meld -y
apt-get install transmission -y
apt-get install libreoffice -y
apt-get install snapd -y
apt-get install gdebi -y
apt-get install software-properties-common -y
apt-get install firefox -y
apt-get remove epiphany-browser -y

# proper git
apt-get install git -y
git config --global user.name $gitUsername
git config --global user.email $userEmail

apt-get install tlp tlp-rdw -y              # save energy blocking background tasks

add-apt-repository ppa:fish-shell/release-3 # fish shell
add-apt-repository ppa:gezakovacs/ppa       # unetbootin
apt-get update
apt-get install fish -y
apt-get install unetbootin -y
apt-get install dconf-editor -y
# dconf-editor => search files > preferences > single click

# docker
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh
rm get-docker.sh
# apt install docker.io

# docker images
docker pull postgres # https://hub.docker.com/_/postgres

# python dependencies
apt install python-pip python3-pip -y
pip install --upgrade pip

# generate SSH Keys
ssh-keygen -t rsa -C $userEmail
chmod 0700 ~/.ssh
chmod 0600 ~/.ssh/id_rsa
chmod 0644 ~/.ssh/id_rsa.pub

touch ~/.bash_aliases
alias lt='ls --human-readable --size -1 -S --classify'

# touch ~/.local/share/applications/firefox.desktop
# [Desktop Entry]
# Version=76.0
# Type=Application
# Name=Firefox Dev
# Exec=/home/gusw/apps/firefox/firefox
# Icon=/home/gusw/apps/firefox/icons/updater.png # TODO change icon name and ref

# multi-touch trackpad
apt-get install xdotool wmctrl libinput-tools -y
mkdir ~/apps
cd ~/apps
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

# keyboard shortcuts
#
#
#
#
#
#
#
#
#
#
#
#
#
#


# dependencies

# apt-get install python-psycopg2 -y
# apt-get install libxml2-dev libxslt-dev -y
# apt-get install git-core -y
# apt-get install -y libxml2-dev libxslt1-dev zlib1g-dev python3-pip -y
# apt-get install build-essential libssl-dev libffi-dev libgmp3-dev -y
# apt-get install virtualenv python-pip libpq-dev python-dev -y
# pip install --upgrade pip
# pip3 install --upgrade setuptools
# pip3 install --upgrade pip
# pip3 install jupyter

############################################ Databases and related

# add-apt-repository -y ppa:linuxgndu/sqlitebrowser
# apt-get update
# sudo apt-get install sqlitebrowser
# apt-get install mysql-server -y
# apt-get install mysql-workbench -y

# pgAdmin4
# mkdir pgAdmin4
# cd pgAdmin4
# virtualenv pgAdmin4

# https://linuxhint.com/install-postgresql-10-on-ubuntu/
# https://ftp.postgresql.org/pub/pgadmin/pgadmin4/v2.1/pip/
# https://askubuntu.com/questions/831262/how-to-install-pgadmin-4-in-desktop-mode-on-ubuntu

# https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-ubuntu-16-04
# sudo docker network create   --driver=bridge  --subnet=172.18.0.0/16  cdocker
# sudo docker run --name seguros_db --net cdocker --ip 172.18.0.10 --restart unless-stopped -e POSTGRES_PASSWORD=marreta -d postgres

############################################ apps

# https://pencil.evolus.vn/Downloads.html
# https://code.visualstudio.com/
# https://www.postman.com/downloads/
# https://www.4kdownload.com/downloads

############################################ ~/.gitconfig
# [user]
# 	email = gustavo.watanabe@gmail.com
# 	name = Gustavo Watanabe

# [core]
# 	editor = vim
# 	pager = less -r
# 	excludesfile = /home/gusw/Documents/code/.gitignore_global

# [push]
# 	default = simple

# [color]
# 	diff = auto
# 	status = auto
# 	branch = auto

# [pretty]
# 	# graph = %C(green)%h %C(auto)%d %C(reset)%s %C(blue)%an%C(reset)
# 	graph = %C(green)%h %C(auto)%d %C(reset)%s %C(blue)%an%C(reset) %C(cyan)(%ar)%C(reset)
# 	log = %C(green)%h %C(reset)%ad %C(auto)%d %C(reset)%s %C(blue)%an%C(reset)

# [alias]
# 	s = status --short --branch
# 	a = !git add -A && git status --short --branch
# 	b = branch --verbose
# 	d = diff
# 	c = commit
# 	ae = commit --amend
# 	an = commit --amend --no-edit
# 	co = checkout
# 	rb = rebase
# 	rbc = rebase --continue
# 	ch = cherry-pick
# 	fm = "!f() { git log --pretty=log --date=short --grep=$1; }; f"
# 	m = merge --no-ff

# 	wip = "!f() { git add -A; git commit -m \"WIP\"; }; f"
# 	cnow = "!f() { git add -A; git commit -m \"`date +%Y-%m-%dT%H:%M`\"; git pull --rebase; git push; }; f"

# 	l = log --graph --pretty=graph --all
# 	lnp = !git --no-pager log --graph --pretty=graph --all

# 	alias = !git config --list | grep 'alias\\.' | sed 's/alias\\.\\([^=]*\\)=\\(.*\\)/\\1\\\t -> \\2/'

# 	# Loads ~/.gitconfig_local.
# 	# Local definition overwrites the ones above.
# 	[include]
# 		path=~/.gitconfig_local
# 	[diff]
# 		tool = meld

############################################ ~/.config/Code/User/settings.json

# {
#     "diffEditor.renderSideBySide": false,

#     "editor.fontSize": 12,
#     "editor.rulers": [119],
#     "editor.renderIndentGuides": false,
#     "editor.renderWhitespace": "all",
#     "editor.wordWrap": "off",
#     "editor.wordBasedSuggestions": false,

#     "files.insertFinalNewline": true,
#     "files.trimTrailingWhitespace": true,
#     "files.autoSave": "off",
#     "files.exclude": {
#         "**/.git": true,
#         "**/*.pyc": true,
#         "**/__pycache__": true,
#         "**/.cache": true
#     },
#     "search.exclude": {
#         "**/.venv": true,
#         "**/.git": true,
#         "**/*.pyc": true,
#         "**/__pycache__": true,
#         "**/.cache": true,
#         "tags": true
#     },

#     "python.linting.pylintEnabled": false,
#     "python.linting.flake8Enabled": true,
#     "python.linting.flake8Args": [
#         "--max-line-length=120"
#     ],

#     "workbench.editor.enablePreview": true,
#     "workbench.activityBar.visible": true,

#     "window.zoomLevel": 0,
#     "window.menuBarVisibility": "toggle",
#     "vsicons.projectDetection.disableDetect": true,
#     "workbench.iconTheme": "vscode-icons",
#     "workbench.colorTheme": "Atom One Dark",

#     "editor.minimap.enabled": true,
#     "editor.minimap.renderCharacters": false,

#     "keyboard.dispatch": "keyCode",
#     "git.enableSmartCommit": true,
#     "indenticator.style": "solid",
#     "[html]": {
#         "editor.tabSize": 2
#     },
#     "[javascript]": {
#         "editor.tabSize": 2
#     },
#     "[css]": {
#         "editor.tabSize": 2
#     },
#     "workbench.startupEditor": "newUntitledFile",
#     "editor.formatOnPaste": false,
#     "emmet.triggerExpansionOnTab": true,
#     "extensions.ignoreRecommendations": false,
#     "gitlens.advanced.messages": {
#         "suppressCommitHasNoPreviousCommitWarning": false,
#         "suppressCommitNotFoundWarning": false,
#         "suppressFileNotUnderSourceControlWarning": false,
#         "suppressGitVersionWarning": false,
#         "suppressLineUncommittedWarning": false,
#         "suppressNoRepositoryWarning": false,
#         "suppressUpdateNotice": false,
#         "suppressWelcomeNotice": true
#     },
#     "telemetry.enableTelemetry": false,
#     "gitlens.advanced.telemetry.enabled": false,
#     "gitlens.codeLens.enabled": false,
#     "git.autofetch": true,
#     "python.disablePromptForFeatures": [
#         "flake8"
#     ]
# }
