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

export STARSHIP_CONFIG=~/.config/starship.toml

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
alias cat=bat
alias vim=nvim

if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH

  autoload -Uz compinit
  compinit
fi

eval "$(rbenv init -)"

eval "$(starship init zsh)"
