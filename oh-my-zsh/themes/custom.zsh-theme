local ret_status="%(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ %s)"
local parent="%{$fg[cyan]%}$(ps -p $PPID -o comm=)"

PROMPT=''

if [ "$parent" != "" ]; then
  PROMPT+="$parent "
fi

PROMPT+='${ret_status}%{$fg_bold[green]%}%p '
PROMPT+='%{$fg[white]%}%~ '
PROMPT+='%{$fg_bold[blue]%}$(git_prompt_info)'
PROMPT+='%{$reset_color%}'

ZSH_THEME_GIT_PROMPT_PREFIX="git:(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}✗%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"
