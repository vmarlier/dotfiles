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
alias kdebug="kubectl run tool-vmarlier --image=nicolaka/netshoot -l sidecar.istio.io/inject=false -i --tty --rm"
alias etcd-debug="kubectl -n admin run -it --rm "etcdctl-vmarlier" \
        --image=quay.io/coreos/etcd:v3.3.10 \
        --env=ETCDCTL_API=3 \
        --env=ETCDCTL_ENDPOINTS="http://etcd-minio.etcd.svc.cluster.local:2379" \
        -- sh"
alias kgetpdb="kubectl get pdb -A -o json | jq -r '.items[] | select(.status.disruptionsAllowed == 0) | .metadata.name'"

### ease working with pleo-io git profile ###
alias config-repo="git config user.email valentin.marlier@pleo.io && git config user.name 'vmarlier2'"

### i'm even more lazy
alias lg="lazygit"
