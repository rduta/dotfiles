#!/bin/bash

echo "Installing system dependencies..."
apt-get update
apt-get install -y stow tmux gnupg lsb-release bat vim ripgrep iputils-ping jq gron moreutils netcat-openbsd screen tig unzip zip ncal fd-find

# not all systems have these packages, so try to isntall but do not fail
apt-get install -y just || true

# Fish shell
source /etc/os-release
echo "deb http://download.opensuse.org/repositories/shells:/fish:/release:/4/Debian_${VERSION_ID}/ /" | tee /etc/apt/sources.list.d/shells-fish-release-4.list
curl -fsSL "https://download.opensuse.org/repositories/shells:/fish:/release:/4/Debian_${VERSION_ID}/Release.key" | gpg --dearmor | tee /etc/apt/trusted.gpg.d/shells_fish_release_4.gpg > /dev/null
apt update -o Dir::Etc::sourcelists="sources.list.d/shells-fish-release-4.list" -o Dir::Etc::sourceparts="-" -o APT::Get::List-Cleanup="0"
apt install -y fish
