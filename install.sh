#!/bin/bash

exec 2>&1
exec > /tmp/dotfiles.log
set -xve

get_user() {
  if [ -n "${SUDO_USER:-}" ]; then
    echo "$SUDO_USER"
  elif [ "$(id -u)" -ne 0 ] && [ -n "${USER:-}" ]; then
    echo "$USER"
  else
    for d in /home/*; do
      if [ -d "$d" ] && [ "$d" != "/home/root" ]; then
        echo "${d#/home/}"
        return
      fi
    done
    echo "vscode"
  fi
}

TARGET_USER=$(get_user)
SCRIPT_DIR="$(cd -P "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if [ "$(id -u)" -eq 0 ] && [ "$TARGET_USER" != "root" ]; then
  echo "Re-executing as $TARGET_USER..."
  exec sudo -u "$TARGET_USER" "$SCRIPT_DIR/install.sh" "$@"
else
  echo "Not re-executing (already running as target user)"
fi

################################################################################


echo "pwd=$(pwd)"
echo "id=$(id)"
echo "HOME=$HOME"
echo "SCRIPT_DIR=$SCRIPT_DIR"
echo "TARGET_USER=$TARGET_USER"

sudo "$SCRIPT_DIR/install-system.sh"
$SCRIPT_DIR/install-user.sh

