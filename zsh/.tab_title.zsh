autoload -Uz add-zsh-hook

typeset -gi TAB_TITLE_MAX_LENGTH=80

_set_tab_title() {
  local title="$1"

  # Replace line breaks, which would break the terminal title.
  title="${title//$'\n'/ }"
  title="${title//$'\r'/ }"

  if (( ${#title} > TAB_TITLE_MAX_LENGTH )); then
    title="${title[1,$(( TAB_TITLE_MAX_LENGTH - 1 ))]}…"
  fi

  # OSC 1: iTerm2 tab title
  # OSC 2: terminal window title
  printf '\e]1;%s\a\e]2;%s\a' "$title" "$title"
}

_short_cwd() {
  print -r -- "${PWD/#$HOME/~}"
}

_git_context() {
  command git rev-parse --is-inside-work-tree &>/dev/null || return

  local branch
  branch="$(command git branch --show-current 2>/dev/null)"

  # Handle detached HEAD.
  if [[ -z "$branch" ]]; then
    branch="$(command git rev-parse --short HEAD 2>/dev/null)"
  fi

  [[ -n "$branch" ]] && print -r -- " [$branch]"
}

_kube_context() {
  local kubeconfig="${KUBECONFIG%%:*}"

  if [[ -n "$kubeconfig" ]]; then
    local filename="${kubeconfig:t}"

    # Example:
    # sre-flux-dev.AdministratorAccess.sre-flux-dev
    # becomes:
    # sre-flux-dev
    print -r -- "${filename##*.}"
    return
  fi

  command kubectl config current-context 2>/dev/null
}

_tab_title_idle() {
  _set_tab_title "$(_short_cwd)$(_git_context)"
}

_tab_title_running() {
  local command_line="$1"
  local -a words

  # Parse the command using Zsh syntax without executing it.
  words=("${(z)command_line}")

  local command_name="${words[1]:t}"

  case "$command_name" in
    vim|nvim)
      # Neovim takes ownership of the title after startup.
      _set_tab_title "(nvim)"
      ;;

    kubectl|k)
      local subcommand="${words[2]:-}"
      local context="$(_kube_context)"
      local title="$command_name"

      [[ -n "$subcommand" ]] && title+=" $subcommand"
      [[ -n "$context" ]] && title+=" | $context"

      _set_tab_title "$title"
      ;;

    git)
      local title="git"

      [[ -n "${words[2]:-}" ]] && title+=" ${words[2]}"
      title+=" · $(_short_cwd)$(_git_context)"

      _set_tab_title "$title"
      ;;

    terraform|tofu)
      local title="$command_name"

      [[ -n "${words[2]:-}" ]] && title+=" ${words[2]}"
      title+=" · $(_short_cwd)"

      _set_tab_title "$title"
      ;;

    docker)
      local title="docker"

      if [[ "${words[2]:-}" == "compose" ]]; then
        title+=" compose"
        [[ -n "${words[3]:-}" ]] && title+=" ${words[3]}"
      elif [[ -n "${words[2]:-}" ]]; then
        title+=" ${words[2]}"
      fi

      title+=" · $(_short_cwd)"

      _set_tab_title "$title"
      ;;

    make)
      local title="make"

      [[ -n "${words[2]:-}" ]] && title+=" ${words[2]}"
      title+=" · $(_short_cwd)"

      _set_tab_title "$title"
      ;;

    *)
      _set_tab_title "$command_line"
      ;;
  esac
}

add-zsh-hook precmd  _tab_title_idle
add-zsh-hook preexec _tab_title_running
