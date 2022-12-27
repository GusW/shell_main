

### vscode - https://linuxhint.com/install-vs-code-manjaro/


### nordvpn - https://wiki.archlinux.org/title/NordVPN
https://aur.archlinux.org/packages/nordvpn-bin

usermod -aG nordvpn $USER
# restart
sudo systemctl start nordvpnd.service
nordvpn login


### docker
# install via Add/Remove software (docker)
# install via Add/Remove software (docker-compose)
sudo systemctl start docker


### pyenv - https://github.com/pyenv/pyenv
# install via Add/Remove software (pyenv)

echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.zshrc
echo 'command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.zshrc
echo 'eval "$(pyenv init -)"' >> ~/.zshrc
exec "$SHELL"

pacman -S --needed base-devel openssl zlib xz tk
pyenv install <version>


### nvm - https://credibledev.com/how-to-install-nodejs-on-manjaro-linux/
sudo pacman -S nvm
echo 'source /usr/share/nvm/init-nvm.sh' >> ~/.zshrc
source ~/.zshrc


### MELD
# install via Add/Remove software (meld)


### VLC
# install via Add/Remove software (vlc)


### GPARTED
# install via Add/Remove software (gparted)


### SIRIKALI
# install via Add/Remove software (sirikali)


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

[credential]
	helper = store
