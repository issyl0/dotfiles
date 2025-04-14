#!/bin/bash

exec > >(tee -i $HOME/dotfiles_install.log)
exec 2>&1

if [[ -z "${CODESPACES}" ]]; then
  echo "==> assuming installing on macOS"
  brew bundle
else
  echo "==> installing in codespace"

  echo "==> rg"
  curl -LO https://github.com/BurntSushi/ripgrep/releases/download/14.1.1/ripgrep_14.1.1-1_amd64.deb
  sudo dpkg -i ripgrep_14.1.1-1_amd64.deb
  rm ripgrep_14.1.1-1_amd64.deb

  echo "==> gh"
  curl -LO https://github.com/cli/cli/releases/download/v2.69.0/gh_2.69.0_linux_amd64.deb
  sudo dpkg -i gh_2.69.0_linux_amd64.deb
  rm gh_2.69.0_linux_amd64.deb

  echo "==> bat"
  curl -LO https://github.com/sharkdp/bat/releases/download/v0.25.0/bat_0.25.0_amd64.deb
  sudo dpkg -i bat_0.25.0_amd64.deb
  rm bat_0.25.0_amd64.deb

  echo "==> zsh-autosuggestions, zsh-syntax-highlighting"
  git clone https://github.com/zsh-users/zsh-autosuggestions $HOME/.zsh/zsh-autosuggestions
  git clone https://github.com/zsh-users/zsh-syntax-highlighting $HOME/.zsh/zsh-syntax-highlighting

  echo "==> starship, atuin"
  curl -sS https://starship.rs/install.sh | sh -s -- -y
  bash <(curl --proto '=https' --tlsv1.2 -sSf https://setup.atuin.sh)
  source $HOME/.atuin/bin/env
fi

echo "==> symlinking dotfiles"
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
  echo "on Codespaces, need to unset git config for GPG signing"
  git config --file ~/.gitconfig --unset user.signingkey
  git config --file ~/.gitconfig --unset gpg.program

  echo "==> setting up atuin"
  export ATUIN_HOST_NAME="codespaces/$GITHUB_REPOSITORY"
  atuin login -u "$GITHUB_USER" -p "$ATUIN_PASSWORD" -k "$ATUIN_KEY"
fi

if [ -d "/workspaces/github" ]; then
  echo "==> setting up git config for Codespaces"
  git config --file ~/.gitconfig user.email "issyl0@github.com"
  git -C /workspaces/github config gpg.program /.codespaces/bin/gh-gpgsign
fi
