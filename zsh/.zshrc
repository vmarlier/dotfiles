# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

### OH MY ZSH ###
export ZSH="/Users/$USER/.oh-my-zsh"
##############

### Golang paths ###
export GO111MODULE=on
export PATH=$PATH:$HOME/go/bin/:/usr/local/lib/ruby/gems/2.6.0/bin
export GOPATH=$HOME/go
##############

export ZSH_DISABLE_COMPFIX=true
export EDITOR="nvim"

### Themes ###
ZSH_THEME="powerlevel10k/powerlevel10k"
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
  macos
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
# zsh and nvim
alias l="lsd -l"
alias ll="lsd -la"
alias vim="nvim"
# venv related
alias venv="source ./venv/bin/activate"
alias dvenv="deactivate"
alias pip="pip3"
alias workon="pew workon"
alias oo="source ~/Git/pleo/pleo/bin/oo.sh"
# ease k8s interaction
alias klo="kubectl logs"
alias kpo="kubectl get pods"
# ease k8s debug pod
alias kdebug="kubectl run tool-vmarlier --image=nicolaka/netshoot -i --tty --rm"
alias etcd-debug="kubectl -n admin run -it --rm "etcdctl-vmarlier" \
        --image=quay.io/coreos/etcd:v3.3.10 \
        --env=ETCDCTL_API=3 \
        --env=ETCDCTL_ENDPOINTS="http://etcd-minio.etcd.svc.cluster.local:2379" \
        -- sh"
# kdebug on a specific nodepool
# kubectl debug node/node-name -it --image=image-name
# alias to ease Git Workflow
alias gpom="git pull origin main"
alias gcm="git checkout main"
alias gcb="git checkout -b"
alias gc="git checkout"
alias gbd="git branch -D"
alias gaa="git add ."
if [ "$(git rev-parse --is-inside-work-tree 2>/dev/null)" ]; then
  alias gr="cd \"$(git rev-parse --show-toplevel)\""
fi
alias config-repo="git config user.email valentin.marlier@pleo.io && git config user.name 'vmarlier2'"
# deal with helmrelease from fluxv1 and fluxv2
export hrv1="helmrelease.helm.fluxcd.io"
export hrv2="helmrelease.helm.toolkit.fluxcd.io"
##############

### k8S ###
source <(kubectl completion zsh)
### kube-ps1 ###
#source "/Users/valentin.marlier/.config/kube-ps1.sh"
#PROMPT=$'\n''$(kube_ps1) '$PROMPT
##############

### asdf ###
. "$HOME/.asdf/asdf.sh"
##############

# Scaleway CLI autocomplete initialization.
# to resolve compaudit problems
# $ compaudit | xargs chmod g-w
# eval "$(scw autocomplete script shell=zsh)"

# Created by `pipx` on 2021-08-11 09:28:24
export PATH="$PATH:/Users/valentin.marlier/.local/bin:${HOME}/.krew/bin"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
