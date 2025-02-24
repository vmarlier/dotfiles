### Load config ###
. ~/.zsh_export.zshrc
. ~/.zsh_aliases.zshrc

### COMPLETION ###
HYPHEN_INSENSITIVE="true"


### git ###
git config --global push.default current

### asdf ###
. "$HOME/.asdf/asdf.sh"

plugins=(
#  alias-tips
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
