
# ADDITIONAL APPS
# Gnome Tweaks
# Gnome Extensions

#SSH KEYS
ssh-keygen -t rsa -C gustavo.watanabe@gmail.com
chmod 0700 ~/.ssh
chmod 0600 ~/.ssh/id_rsa
chmod 0644 ~/.ssh/id_rsa.pub

# NORDVPN
sh <(curl -sSf https://downloads.nordcdn.com/apps/linux/install.sh)
sudo usermod -aG nordvpn $USER
# reboot
nordvpn login

# VSCODE
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
sudo dnf check-update
sudo dnf install code

# MELD
sudo dnf -y install meld

# Terminator
sudo dnf -y install terminator

# NEMO file manager
sudo dnf makecache
sudo dnf install nemo.x86_64

# DOCKER
sudo dnf -y install dnf-plugins-core
sudo dnf config-manager \
    --add-repo \
    https://download.docker.com/linux/fedora/docker-ce.repo
sudo dnf install docker-ce docker-ce-cli containerd.io
sudo usermod -aG docker $USER
sudo systemctl start docker
# on boot
# sudo systemctl enable docker.service
# sudo systemctl enable containerd.service
# disable boot
# sudo systemctl disable docker.service
# sudo systemctl disable containerd.service
sudo docker images

# DOCKER-COMPOSE
sudo dnf install docker-compose

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

# Python dependencies
pip install --upgrade pip
pip install --upgrade setuptools
pip install --upgrade pygments ipykernel
pip install virtualenv

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
sudo dnf install \
  https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
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

# VirtualBox
sudo wget http://download.virtualbox.org/virtualbox/rpm/fedora/virtualbox.repo -P /etc/yum.repos.d/
sudo dnf update
sudo dnf install @development-tools dkms
sudo dnf search VirtualBox
sudo dnf install VirtualBox-<versiob>.x86_64
sudo usermod -aG vboxusers $USER
sudo /sbin/vboxconfig
# https://www.virtualbox.org/wiki/Downloads -> Extension Pack

# CHROME
sudo rpm --import https://dl.google.com/linux/linux_signing_key.pub
wget https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm
sudo dnf install google-chrome-stable_current_x86_64.rpm -y

# GPARTED
sudo dnf install -y gparted

# GIMP
sudo dnf install -y gimp

# SIRIKALI
sudo dnf config-manager --add-repo https://copr.fedorainfracloud.org/coprs/dawid/gocryptfs/repo/fedora-36/dawid-gocryptfs-fedora-36.repo
sudo dnf makecache --refresh
sudo dnf -y install gocryptfs
sudo dnf install sirikali.x86_64

# number of kernels retained
cat /etc/dnf/dnf.conf | grep installonly_limit
