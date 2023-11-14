### Load config ###
. ~/.zsh_export.zshrc
. ~/.zsh_aliases.zshrc

### Themes ###
ZSH_THEME="powerlevel10k/powerlevel10k"

### COMPLETION ###
HYPHEN_INSENSITIVE="true"

plugins=(
  alias-tips
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

### asdf ###
. "$HOME/.asdf/asdf.sh"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
