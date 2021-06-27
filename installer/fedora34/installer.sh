
# ADDITIONAL APPS
# Chrome
# Terminator
# Meld
# GParted
# GIMP
# Gnome Tweaks
# Gnome Extensions

#SSH KEYS
ssh-keygen -t rsa -C gustavo.watanabe@gmail.com
chmod 0700 ~/.ssh
chmod 0600 ~/.ssh/id_rsa
chmod 0644 ~/.ssh/id_rsa.pub

# VSCODE
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
sudo dnf check-update
sudo dnf install code

# DOCKER
sudo dnf -y install dnf-plugins-core
sudo dnf config-manager \
    --add-repo \
    https://download.docker.com/linux/fedora/docker-ce.repo
sudo dnf install docker-ce docker-ce-cli containerd.io
sudo systemctl start docker
sudo docker images

# DOCKER-COMPOSE
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo docker-compose --version

# PY/ENV
sudo dnf install make gcc zlib-devel bzip2 bzip2-devel readline-devel sqlite sqlite-devel openssl-devel tk-devel libffi-devel xz-devel
curl https://pyenv.run | bash
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc
echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc
echo -e 'if command -v pyenv 1>/dev/null 2>&1; then\n eval "$(pyenv init --path)"\nfi' >> ~/.bashrc
exec #SHELL
# reload terminal...
pyenv init
pyenv install --list
pyenv install <version>
pyenv global <version>

# NVM
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash
# reload terminal...
nvm ls-remote
nvm install <version>

# DNF
echo 'fastestmirror=1' | sudo tee -a /etc/dnf/dnf.conf
echo 'max_parallel_downloads=10' | sudo tee -a /etc/dnf/dnf.conf
echo 'deltarpm=true' | sudo tee -a /etc/dnf/dnf.conf
cat /etc/dnf/dnf.conf

# VLC
sudo dnf install -y vlc

# Additional codecs (if not VLC)
sudo dnf groupupdate sound-and-video
sudo dnf install -y gstreamer1-plugins-{bad-\*,good-\*,ugly-\*,base} gstreamer1-libav --exclude=gstreamer1-plugins-bad-free-devel ffmpeg gstreamer-ffmpeg
sudo dnf install -y lame\* --exclude=lame-devel
sudo dnf group upgrade --with-optional Multimedia

# Firefox H264 Codecs
sudo dnf config-manager --set-enabled fedora-cisco-openh264
sudo dnf install -y gstreamer1-plugin-openh264 mozilla-openh264
# Firefox menu → Add-ons → Plugins and enable OpenH264 plugin.

### ~/.config/Code/User/settings.json

# {
#   "editor.rulers": [119],
#   "editor.renderIndentGuides": false,
#   "editor.renderWhitespace": "all",
#   "editor.wordWrap": "off",
#   "editor.wordBasedSuggestions": false,

#   "files.insertFinalNewline": true,
#   "files.trimTrailingWhitespace": true,
#   "files.autoSave": "off",
#   "files.exclude": {
#     "**/.git": true,
#     "**/*.pyc": true,
#     "**/__pycache__": true,
#     "**/.cache": true
#   },
#   "search.exclude": {
#     "**/.venv": true,
#     "**/.git": true,
#     "**/*.pyc": true,
#     "**/__pycache__": true,
#     "**/.cache": true,
#     "tags": true
#   },

#   "python.linting.pylintEnabled": false,
#   "python.linting.flake8Enabled": true,
#   "python.linting.flake8Args": ["--max-line-length=120"],

#   "workbench.editor.enablePreview": true,
#   "workbench.activityBar.visible": true,
#   "window.menuBarVisibility": "toggle",
#   "vsicons.projectDetection.disableDetect": true,
#   "workbench.colorTheme": "Atom One Dark",

#   "editor.minimap.enabled": true,
#   "editor.minimap.renderCharacters": false,

#   "keyboard.dispatch": "keyCode",
#   "git.enableSmartCommit": true,
#   "[html]": {
#     "editor.tabSize": 2,
#     "editor.defaultFormatter": "esbenp.prettier-vscode"
#   },
#   "[javascript]": {
#     "editor.tabSize": 2,
#     "editor.defaultFormatter": "esbenp.prettier-vscode"
#   },
#   "[javascriptreact]": {
#     "editor.tabSize": 2,
#     "editor.defaultFormatter": "esbenp.prettier-vscode"
#   },
#   "[css]": {
#     "editor.tabSize": 2
#   },
#   "workbench.startupEditor": "newUntitledFile",
#   "editor.formatOnPaste": true,
#   "editor.formatOnSave": true,
#   "emmet.triggerExpansionOnTab": true,
#   "extensions.ignoreRecommendations": false,
#   "telemetry.enableTelemetry": false,
#   "git.autofetch": true,
#   "editor.minimap.maxColumn": 30,
#   "terminal.integrated.fontSize": 12,
#   "atomKeymap.promptV3Features": true,
#   "editor.multiCursorModifier": "ctrlCmd",
#   "debug.console.fontSize": 11,
#   "editor.fontSize": 10,
#   "workbench.iconTheme": "vscode-icons",
#   "jupyter.askForKernelRestart": false,
#   "jupyter.interactiveWindowMode": "perFile",
#   "vsicons.dontShowNewVersionMessage": true,
#   "workbench.editorAssociations": {
#     "*.ipynb": "jupyter.notebook.ipynb"
#   },
#   "[typescriptreact]": {
#     "editor.defaultFormatter": "vscode.typescript-language-features"
#   },
#   "[typescript]": {
#     "editor.defaultFormatter": "esbenp.prettier-vscode"
#   },
#   "[markdown]": {
#     "editor.defaultFormatter": "esbenp.prettier-vscode"
#   },
#   "[json]": {
#     "editor.defaultFormatter": "esbenp.prettier-vscode"
#   },
#   "editor.defaultFormatter": "esbenp.prettier-vscode"
# }
