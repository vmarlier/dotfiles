### Load config ###
. ~/.zsh_export.zshrc
. ~/.zsh_aliases.zshrc

### COMPLETION ###
HYPHEN_INSENSITIVE="true"

plugins=(
#  alias-tips
  asdf
  aws
  git
  kubectl
  scw
  zsh-autosuggestions
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh
source $(pew shell_config)
source <(kubectl completion zsh)
source ~/Git/valentin.marlier/backups/Access/swenv_completion.zsh

### git ###
git config --global push.default current

### asdf ###
. "$HOME/.asdf/asdf.sh"

eval "$(starship init zsh)"
