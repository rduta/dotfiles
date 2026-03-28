#!/bin/bash

exec 2>&1
exec > /tmp/dotfiles.log

set -xve

ARCH=$(dpkg --print-architecture)
echo "Installing dependencies..."
sudo apt-get update
sudo apt-get install -y stow tmux gnupg lsb-release bat vim ripgrep iputils-ping jq moreutils netcat-openbsd screen tig unzip zip ncal

# Download the latest Fish shell deb (official "latest" link)
source /etc/os-release
echo "deb http://download.opensuse.org/repositories/shells:/fish:/release:/4/Debian_${VERSION_ID}/ /" | sudo tee /etc/apt/sources.list.d/shells-fish-release-4.list
curl -fsSL "https://download.opensuse.org/repositories/shells:/fish:/release:/4/Debian_${VERSION_ID}/Release.key" | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/shells_fish_release_4.gpg > /dev/null
sudo apt update -o Dir::Etc::sourcelists="sources.list.d/shells-fish-release-4.list" -o Dir::Etc::sourceparts="-" -o APT::Get::List-Cleanup="0"
sudo apt install -y fish

# Install fzf
echo "Installing fzf..."
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --bin

# Install fzf-git
echo "Installing fzf-git..."
git clone --depth 1 https://github.com/junegunn/fzf-git.sh.git ~/.fzf-git

echo "Installing starship..."
curl -s https://starship.rs/install.sh | sh -s -- -y

# Backup existing configs
[ -f $HOME/.vimrc ] && mv $HOME/.vimrc $HOME/.vimrc_before_dotfiles
[ -f $HOME/.tmux.conf ] && mv $HOME/.tmux.conf $HOME/.tmux.conf_before_dotfiles

pushd $HOME/dotfiles
for folder in bash fish tmux vim; do
  echo "stow $folder"
  stow -D $folder 2>/dev/null || true
  stow -t $HOME $folder
done
popd
