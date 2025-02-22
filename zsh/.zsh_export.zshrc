### OH MY ZSH ###
export ZSH="/Users/$USER/.oh-my-zsh"
export ZSH_DISABLE_COMPFIX=true

### Golang paths ###
export GO111MODULE=on
export PATH=$PATH:$HOME/go/bin/:/usr/local/lib/ruby/gems/2.6.0/bin:/Users/valentin.marlier/.yarn/bin
export GOPATH=$HOME/go
export GOPRIVATE=github.com/pleo-io

### Common
export EDITOR="nvim"

# deal with helmrelease from fluxv1 and fluxv2
export hr="helmrelease.helm.toolkit.fluxcd.io"

# podman
export DOCKER_HOST="unix://${HOME}/.local/share/containers/podman/machine/podman.sock"

# krew
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

# brew is annoying
export HOMEBREW_NO_AUTO_UPDATE=1
