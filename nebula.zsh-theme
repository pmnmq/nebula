function preexec() {
  timer=${timer:-$SECONDS}
}

function precmd() {
  if [ $timer ]; then
    timer_show=$(($SECONDS - $timer))
    if [[ $timer_show -ge $min_show_time ]]; then
      RPROMPT='%{$fg_no_bold[cyan]%} ${timer_show}s %f%{$fg_bold[white]%} %* %f %{$reset_color%}%'
    else
      RPROMPT='%{$fg_bold[white]%}[%*]%f'
    fi
    unset timer
  fi
}

BLUE=$fg_no_bold[blue]
CYAN=$fg_no_bold[cyan]
RESET=$reset_color

PROMPT='%{$FG[075]%}%n%{$fg[white]%}@%m:%{$fg_bold[blue]%}${PWD/#$HOME/~} $(git_prompt_info)%{$CYAN%}»%{$RESET%} '


ZSH_THEME_GIT_PROMPT_PREFIX="$FG[075]‹$FG[078]"
ZSH_THEME_GIT_PROMPT_CLEAN=""
ZSH_THEME_GIT_PROMPT_DIRTY="$FG[214]*%{$RESET%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="$FG[075]›%{$RESET%}"
autoload -Uz add-zsh-hook
add-zsh-hook preexec preexec
add-zsh-hook precmd precmd
