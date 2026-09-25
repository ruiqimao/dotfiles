local ret_status="%(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ %s)"

local parent_comm
parent_comm="$(ps -p $PPID -o comm=)"
case $parent_comm in
  /usr/bin/login|login)
    parent_comm=""
    ;;
esac
if [[ -n $TERM_PROGRAM && $parent_comm == *"$TERM_PROGRAM"* ]]; then
  parent_comm=""
fi
local parent="%{$fg[cyan]%}${parent_comm:t}"

PROMPT=''

if [[ -n $parent_comm ]]; then
  PROMPT+="$parent "
fi

PROMPT+='${ret_status}%{$fg_bold[green]%}%p'
PROMPT+='%{$fg[white]%}%~ '
PROMPT+='%{$fg_bold[blue]%}$(git_prompt_info)'
PROMPT+='%{$reset_color%}'

ZSH_THEME_GIT_PROMPT_PREFIX="git:(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}✗%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"
