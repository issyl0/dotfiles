export RBENV_ROOT="$HOME/.rbenv"
export GOPATH=$HOME/go
export PATH=$HOME/bin:/usr/local/bin:/usr/local/sbin:$GOPATH/bin:$HOME/.cargo/bin:$PATH

export GPG_TTY="$(tty)"
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
gpgconf --launch gpg-agent

export LANG=en_US.UTF-8
export EDITOR="vim"

export HOMEBREW_BINTRAY_USER=issyl0
export HOMEBREW_DEVELOPER=1
export HOMEBREW_GITHUB_USER=issyl0
export HOMEBREW_NO_AUTO_UPDATE=1
export HOMEBREW_NO_ANALYTICS=1
export HOMEBREW_SORBET=1

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

if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH

  autoload -Uz compinit
  compinit
fi

HB_CNF_HANDLER="$(brew --prefix)/Homebrew/Library/Taps/homebrew/homebrew-command-not-found/handler.sh"
if [ -f "$HB_CNF_HANDLER" ]; then
  source "$HB_CNF_HANDLER";
fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
eval "$(rbenv init -)"

eval "$(starship init zsh)"
