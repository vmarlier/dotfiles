### Load config ###
. ~/.zsh_export.zshrc
. ~/.zsh_aliases.zshrc

### COMPLETION ###
HYPHEN_INSENSITIVE="true"

### git ###
git config --global push.default current
git config --global pull.default current
git config --global url.git@github.com:.insteadof https://github.com/

### asdf ###

plugins=(
# alias-tips
  asdf
  aws
  git
  kubectl
  scw
  zsh-autosuggestions
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh
source <(kubectl completion zsh)
source ~/Git/valentin.marlier/backups/Access/swenv_completion.zsh

eval "$(starship init zsh)"

# Created by `pipx` on 2026-05-06 14:22:29
export PATH="$PATH:/Users/valentin.marlier/.local/bin"

# auto tab naming
source ~/Git/valentin.marlier/dotfiles/zsh/.tab_title.zsh
