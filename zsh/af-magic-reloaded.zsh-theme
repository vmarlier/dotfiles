# af-magic-reloaded.zsh-theme
# Based on the work of Andy Fleming
# URL: http://andyfleming.com/
#
# Editor: Valentin Marlier

# primary prompt: dashed separator, directory and vcs info
PS1="
${FG[237]}\${(l.\$(echo $COLUMNS)..-.)}%{$reset_color%}
${FG[032]}╭─ %~\$(git_prompt_info)\$(hg_prompt_info) 
${FG[032]}╰─ %{$reset_color%}${FG[105]}%(!.#.»)%{$reset_color%} "

PS2="%{$fg[red]%}\ %{$reset_color%}"

# right prompt: return code, virtualenv and context (user@host)
RPS1="%(?..%{$fg[red]%}%? ↵%{$reset_color%})"
if (( $+functions[virtualenv_prompt_info] )); then
  RPS1+='$(virtualenv_prompt_info)'
fi
RPS1+=" ⌚ %{$fg_bold[red]%}%*%{$reset_color%}"

# git settings
ZSH_THEME_GIT_PROMPT_PREFIX=" on %{$fg[magenta]%}\uE0A0 "
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN=""
ZSH_THEME_GIT_PROMPT_DIRTY="${FG[214]}*%{$reset_color%}"

# hg settings
ZSH_THEME_HG_PROMPT_PREFIX=" ${FG[075]}(${FG[078]}"
ZSH_THEME_HG_PROMPT_CLEAN=""
ZSH_THEME_HG_PROMPT_DIRTY="${FG[214]}*%{$reset_color%}"
ZSH_THEME_HG_PROMPT_SUFFIX="${FG[075]})%{$reset_color%}"

# virtualenv settings
ZSH_THEME_VIRTUALENV_PREFIX=" ${FG[075]}["
ZSH_THEME_VIRTUALENV_SUFFIX="]%{$reset_color%}"