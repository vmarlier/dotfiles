### OH MY ZSH ###
export ZSH="/Users/$USER/.oh-my-zsh"
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
export EDITOR="nvim"

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
  asdf
  aws
  docker
  git
  golang
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

### Pew ###
source $(pew shell_config)
##############

### Aliases ###
alias l="lsd -l"
alias ll="lsd -la"
alias vim="nvim"
alias venv="source ./venv/bin/activate"
alias dvenv="deactivate"
alias pip="pip3"
alias swenv=". switch_env"
alias workon="pew workon"
alias kdebug="kubectl run tool-vmarlier --image=nicolaka/netshoot -i --tty --rm"
alias etcd-debug="kubectl -n admin run -it --rm "etcdctl-vmarlier" \
        --image=quay.io/coreos/etcd:v3.3.10 \
        --env=ETCDCTL_API=3 \
        --env=ETCDCTL_ENDPOINTS="http://etcd-minio.etcd.svc.cluster.local:2379" \
        -- sh"
# kdebug on a specific nodepool
# kubectl run tool-vmarlier-1 --image=nicolaka/netshoot -i --tty --rm -n tooling --overrides='{ "spec": { "nodeSelector": { "agentpool": "user" }} }'
alias gpom="git pull origin master"
alias gcm="git checkout master"
alias gcb="git checkout -b"
alias gc="git checkout"
# deal with helmrelease from fluxv1 and fluxv2
export hrv1="helmrelease.helm.fluxcd.io"
export hrv2="helmrelease.helm.toolkit.fluxcd.io"
##############

### k8S ###
source <(kubectl completion zsh)
##############

### asdf ###
export ASDF_DIR='/usr/local/opt/asdf/libexec'
##############

# Scaleway CLI autocomplete initialization.
# to resolve compaudit problems
# $ compaudit | xargs chmod g-w
eval "$(scw autocomplete script shell=zsh)"

# Created by `pipx` on 2021-08-11 09:28:24
export PATH="$PATH:/Users/vmarlier/.local/bin:${HOME}/.krew/bin"
