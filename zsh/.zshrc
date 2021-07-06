### OH MY ZSH ###
export ZSH="/Users/vmarlier/.oh-my-zsh"
##############
### Golang paths ###
export GO111MODULE=on
export PATH=$PATH:$HOME/go/bin/:/usr/local/lib/ruby/gems/2.6.0/bin
export GOPATH=$HOME/go
##############

### Git SSH config ###
export GIT_SSH_COMMAND="ssh -i ~/.ssh/github/id_ed25519"
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

### Plugins ###
plugins=(
  aws
  git
  golang
  kubectl
  docker
  terraform
  scw
  zsh-autosuggestions
  zsh-syntax-highlighting
)
# For zsh-autosuggestions and zsh-syntax-highlighting
# Install with this command: 
# $ git clone https://github.com/zsh-users/zsh-syntax-highlighting ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
##############

### OH MY ZSH ###
source $ZSH/oh-my-zsh.sh
##############

### Aliases ###
alias l="lsd -l"
alias ll="lsd -la"
alias vim="nvim"
alias venv="source ./venv/bin/activate"
alias dvenv="deactivate"
alias pip="pip3"
##############

# Scaleway CLI autocomplete initialization.
# to resolve compaudit problems
# $ compaudit | xargs chmod g-w
#eval "$(scw autocomplete script shell=zsh)"
