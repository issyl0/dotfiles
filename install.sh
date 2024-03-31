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
fi

ln -sf $(pwd)/.gitignore_global $HOME/.gitignore_global
ln -sf $(pwd)/.gitconfig $HOME/.gitconfig
ln -sf $(pwd)/.gitconfig-github $HOME/.gitconfig-github

if [[ -z "${CODESPACES}" ]]; then
  echo "not on Codespaces, don't need to unset git config for GPG signing"
else
  git config --file ~/.gitconfig --unset user.email
  git config --file ~/.gitconfig --unset user.signingkey
  git config --file ~/.gitconfig --unset gpg.program
fi

if [ -d "/workspaces/github" ]; then
  git -C /workspaces/github config gpg.program /.codespaces/bin/gh-gpgsign
fi
