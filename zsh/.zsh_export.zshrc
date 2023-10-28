### OH MY ZSH ###
export ZSH="/Users/$USER/.oh-my-zsh"
export ZSH_DISABLE_COMPFIX=true

### Golang paths ###
export GO111MODULE=on
export PATH=$PATH:$HOME/go/bin/:/usr/local/lib/ruby/gems/2.6.0/bin
export GOPATH=$HOME/go

### Common
export EDITOR="nvim"

# deal with helmrelease from fluxv1 and fluxv2
export hr="helmrelease.helm.toolkit.fluxcd.io"
