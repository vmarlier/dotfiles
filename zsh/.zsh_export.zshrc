### OH MY ZSH ###
export ZSH="/Users/$USER/.oh-my-zsh"
export ZSH_DISABLE_COMPFIX=true

### Golang paths ###
export GO111MODULE=on
export PATH=$PATH:$HOME/go/bin/
export GOPATH=$HOME/go
export GOPRIVATE=github.com/pleo-io

### Ruby gems path
export PATH=$PATH:/usr/local/lib/ruby/gems/2.6.0/bin

### Yarn path
export PATH=$PATH:$HOME/.yarn/bin

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

# default editor for man
export MANPAGER="nvim +Man!"
