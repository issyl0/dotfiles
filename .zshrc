#!/bin/zsh

if [[ -d /opt/homebrew ]]; then
  eval $(/opt/homebrew/bin/brew shellenv)
fi
export RBENV_ROOT="$HOME/.rbenv"
export GOPATH=$HOME/go
export PATH=$HOME/bin:/usr/local/bin:/usr/local/sbin:$GOPATH/bin:$HOME/.cargo/bin:$PATH
export GPG_TTY="$(tty)"
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
gpgconf --launch gpg-agent

autoload -Uz compinit
compinit

if type brew &>/dev/null; then # on macOS
  FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH
  compinit

  source "$(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
else # must be on Linux, ie a Codespace
  source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

bindkey "^A" vi-beginning-of-line
bindkey "^E" vi-end-of-line

alias ack=rg
alias ag=rg
alias bef="brew edit"
alias bibf="brew install --force-bottle"
alias bisf="brew install -s"
alias brf="brew reinstall"
alias btf="brew test"
alias bx="bundle exec"
alias cat=bat
alias gcf="git commit --fixup"
alias gcm="git commit -m"
alias gco="git checkout"
alias gcob="git checkout -b"
alias ghgh="gh cs create -R github/github --devcontainer-path .devcontainer/devcontainer.json -b master -m largePremiumLinux"
alias glom="git log --oneline ...master"
alias gpx="git log -S"
alias gpxd="git log -pS"
alias grb="git rebase"
alias gs="git status"

export HOMEBREW_DEVELOPER=1
export HOMEBREW_GITHUB_USER=issyl0
export HOMEBREW_NO_AUTO_UPDATE=1
export HOMEBREW_NO_ANALYTICS=1

export EDITOR="code -w"
export GIT_EDITOR="code -w"

eval "$(rbenv init -)"
eval "$(atuin init zsh)"
eval "$(starship init zsh)"
