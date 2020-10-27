### OH MY ZSH ###
export ZSH="/Users/valentin/.oh-my-zsh"
##############

### Golang paths ###
export GO111MODULE=on
export PATH=$PATH:$HOME/go/bin/:/usr/local/lib/ruby/gems/2.6.0/bin
export GOPATH=$HOME/go
##############

export ZSH_DISABLE_COMPFIX=true

### Themes ###
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="af-magic"
##############

### COMPLETION ###
# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"
##############

plugins=(
  aws
  git
  golang
  kubectl
  terraform
  scw
  zsh-autosuggestions
  zsh-syntax-highlighting
)

### OH MY ZSH ###
source $ZSH/oh-my-zsh.sh
##############

### Aliases ###
alias l="lsd -l"
alias ll="lsd -la"
alias vim="nvim"
alias venv="source ./venv/bin/activate"
alias dvenv="deactivate"
##############

# Scaleway CLI autocomplete initialization.
eval "$(scw autocomplete script shell=zsh)"
