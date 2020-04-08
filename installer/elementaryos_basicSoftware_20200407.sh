#!/bin/bash

gitUsername="Gustavo Watanabe"
gitUseremail="gustavo.watanabe@gmail.com"

apt-get update
apt-get install gimp -y
apt-get install gedit -y
apt-get install vim -y
apt-get install sshpass -y
apt-get install gawk -y
apt-get install terminator -y
apt-get install virtualenv -y
apt-get install gparted -y
apt-get install golang-go -y
apt-get install meld -y
apt-get install transmission -y
apt-get install git -y

git config --global user.name $gitUsername
git config --global user.email $gitUseremail

# unetbootin
apt install software-properties-common -y
add-apt-repository ppa:gezakovacs/ppa
apt-get update
apt-get install unetbootin -y

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
#     "editor.autoIndent": false,
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
