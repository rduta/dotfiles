#!/bin/bash

echo "Installing fzf..."
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --bin

echo "Installing fzf-git..."
git clone --depth 1 https://github.com/junegunn/fzf-git.sh.git ~/.fzf-git

echo "Installing starship..."
curl -s https://starship.rs/install.sh | sh -s -- -y

# Backup existing configs
[ -f "$HOME/.vimrc" ] && mv "$HOME/.vimrc" "$HOME/.vimrc_before_dotfiles"
[ -f "$HOME/.tmux.conf" ] && mv "$HOME/.tmux.conf" "$HOME/.tmux.conf_before_dotfiles"

DOTFILES_DIR="$(cd -P "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
echo "Using dotfiles dir: $DOTFILES_DIR"
for folder in bash fish tmux vim git; do
  echo "stow $folder"
  stow -D -d "$DOTFILES_DIR" -t "$HOME" $folder 2>/dev/null || true
  stow -d "$DOTFILES_DIR" -t "$HOME" $folder 2>/dev/null || true
done
