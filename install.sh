#!/bin/bash

exec > >(tee -i $HOME/dotfiles_install.log)
exec 2>&1
set -x

if [[ -z "${CODESPACES}" ]]; then
  echo "==> assuming installing on macOS"
  brew bundle
else
  echo "==> installing in codespace"
  sudo apt-get update
  sudo apt install -y -o Dpkg::Options::="--force-overwrite" bat

  curl -sS https://starship.rs/install.sh | sh
  bash <(curl --proto '=https' --tlsv1.2 -sSf https://setup.atuin.sh)
fi

ln -sf $(pwd)/.gitignore_global $HOME/.gitignore_global
ln -sf $(pwd)/.gitconfig $HOME/.gitconfig
ln -sf $(pwd)/.zshrc $HOME/.zshrc
ln -sf $(pwd)/starship.toml $HOME/.config/starship.toml

mkdir -p $HOME/.config/atuin
ln -sf $(pwd)/atuin-config.toml $HOME/.config/atuin/config.toml

if [[ -z "${CODESPACES}" ]]; then
  echo "not on Codespaces, don't need to unset git config for GPG signing"
  # Write the following to the end of `.gitconfig`.
  cat <<-EOF >> $(pwd)/.gitconfig
[credential]
username = issyl0
[gpg]
format = ssh
[gpg "ssh"]
program = /Applications/1Password.app/Contents/MacOS/op-ssh-sign
[credential "https://github.com"]
helper =
helper = !/opt/homebrew/bin/gh auth git-credential
[credential "https://gist.github.com"]
helper =
helper = !/opt/homebrew/bin/gh auth git-credential
EOF
else
  git config --file ~/.gitconfig --unset user.signingkey
  git config --file ~/.gitconfig --unset gpg.program

  export ATUIN_HOST_NAME="codespaces/$GITHUB_REPOSITORY"
  atuin login -u "$GITHUB_USER" -p "$ATUIN_PASSWORD" -k "$ATUIN_KEY"
fi

if [ -d "/workspaces/github" ]; then
  git config --file ~/.gitconfig user.email "issyl0@github.com"
  git -C /workspaces/github config gpg.program /.codespaces/bin/gh-gpgsign
fi
