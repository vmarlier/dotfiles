### swenv script ###
alias swenv=". swenv"

### zsh and nvim ###
alias l="lsd -l"
alias ll="lsd -la"
alias vim="nvim"

### ease k8s debug pod ###
alias kdebug="kubectl run tool-vmarlier --image=nicolaka/netshoot -l sidecar.istio.io/inject=false -l pleo.io/security-level=public -i --tty --rm"
alias etcd-debug="kubectl -n admin run -it --rm "etcdctl-vmarlier" \
        --image=quay.io/coreos/etcd:v3.3.10 \
        --env=ETCDCTL_API=3 \
        --env=ETCDCTL_ENDPOINTS="http://etcd-minio.etcd.svc.cluster.local:2379" \
        -- sh"
alias kgetpdb="kubectl get pdb -A -o json | jq -r '.items[] | select(.status.disruptionsAllowed == 0) | .metadata.name'"
alias kaf="kubectl apply -f"
alias kdf="kubectl delete -f"

### others ###
alias claud="tokview wrap claude"
alias claude="tokview wrap claude"
alias claude-litellm='source ~/.litellm/litellm-keys.env && ANTHROPIC_BASE_URL=http://localhost:4000 ANTHROPIC_AUTH_TOKEN="$LITELLM_MASTER_KEY" ANTHROPIC_MODEL=claude-sonnet-5 command claude'

###
alias grep="rg"
alias kubectl=kubecolor
