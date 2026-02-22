#!/usr/bin/env bash
set -e

# Install personal packages
sudo apt-get update && sudo apt-get install -y \
    ripgrep fd-find bat zsh powerline fonts-powerline \
    # ... your list

# Install oh-my-zsh, starship, etc.
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
# Or use your preferred tool (chezmoi, yadm, etc.)

