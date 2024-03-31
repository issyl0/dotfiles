#!/bin/bash

exec > >(tee -i $HOME/dotfiles_install.log)
exec 2>&1
set -x

if [[ -z "${CODESPACES}" ]]; then
  echo "==> assuming installing on macOS"
  brew bundle
else
  echo "==> installing dotfiles in codespace"
  sudo apt-get update
  sudo apt install -y -o Dpkg::Options::="--force-overwrite" bat
  curl -sS https://starship.rs/install.sh | sh

  sudo chsh "$(id -un)" --shell "/usr/bin/zsh"
fi

ln -sf $(pwd)/.gitignore_global $HOME/.gitignore_global
ln -sf $(pwd)/.gitconfig $HOME/.gitconfig

if [[ -z "${CODESPACES}" ]]; then
  echo "not on Codespaces, don't need to unset git config for GPG signing"
else
  git config --file ~/.gitconfig --unset user.email
  git config --file ~/.gitconfig --unset user.signingkey
  git config --file ~/.gitconfig --unset gpg.program

  ATUIN_HOST_NAME="codespace/$GITHUB_REPOSITORY"
  ATUIN_HOST_USER=$GITHUB_USER
fi

if [ -d "/workspaces/github" ]; then
  git config --file ~/.gitconfig user.email "issyl0@github.com"
  git -C /workspaces/github config gpg.program /.codespaces/bin/gh-gpgsign
fi
