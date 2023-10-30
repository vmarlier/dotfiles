### swenv script ###
alias swenv=". swenv"

### zsh and nvim ###
alias l="lsd -l"
alias ll="lsd -la"
alias vim="nvim"

### venv related ###
alias venv="source ./venv/bin/activate"
alias dvenv="deactivate"
alias pip="pip3"
alias workon="pew workon"

### ease k8s debug pod ###
alias kdebug="kubectl run tool-vmarlier --image=nicolaka/netshoot -i --tty --rm"
alias etcd-debug="kubectl -n admin run -it --rm "etcdctl-vmarlier" \
        --image=quay.io/coreos/etcd:v3.3.10 \
        --env=ETCDCTL_API=3 \
        --env=ETCDCTL_ENDPOINTS="http://etcd-minio.etcd.svc.cluster.local:2379" \
        -- sh"

### alias to ease Git Workflow ###
alias gpom="git pull origin main"
alias gcm="git checkout main"
alias gcb="git checkout -b"
alias gc="git checkout"
alias gbd="git branch -D"
alias gaa="git add ."
if [ "$(git rev-parse --is-inside-work-tree 2>/dev/null)" ]; then
  alias gr="cd \"$(git rev-parse --show-toplevel)\""
fi

### ease working with pleo-io git profile ###
alias config-repo="git config user.email valentin.marlier@pleo.io && git config user.name 'vmarlier2'"
