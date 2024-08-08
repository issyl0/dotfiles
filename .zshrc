eval $(/opt/homebrew/bin/brew shellenv)
export RBENV_ROOT="$HOME/.rbenv"
export GOPATH=$HOME/go
export PATH=$HOME/bin:/usr/local/bin:/usr/local/sbin:$GOPATH/bin:$HOME/.cargo/bin:$PATH

export GPG_TTY="$(tty)"
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
gpgconf --launch gpg-agent

export LANG=en_US.UTF-8
export EDITOR="code -w"
export GIT_EDITOR="code -w"

export HOMEBREW_DEVELOPER=1
export HOMEBREW_GITHUB_USER=issyl0
export HOMEBREW_NO_AUTO_UPDATE=1
export HOMEBREW_NO_ANALYTICS=1

bindkey "^A" vi-beginning-of-line
bindkey "^E" vi-end-of-line

alias ack=rg
alias ag=rg
alias bef="brew edit"
alias bisf="brew install -s"
alias bibf="brew install --force-bottle"
alias brf="brew reinstall"
alias btf="brew test"
alias bx="bundle exec"
alias glom="git log --oneline ...master"
alias gco="git checkout"
alias gcob="git checkout -b"
alias gcf="git commit --fixup"
alias grb="git rebase"
alias gcm="git commit -m"
alias nvim="code -w"
alias cat=bat
alias vim=nvim
alias ghgh="gh cs create -R github/github --devcontainer-path .devcontainer/devcontainer.json -b master -m largePremiumLinux"

if type brew &>/dev/null
then
  FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH

  autoload -Uz compinit
  compinit

  export STARSHIP_CONFIG=~/.config/starship.toml
  eval "$(starship init zsh)"
fi

eval "$(rbenv init -)"
eval "$(atuin init zsh)"
