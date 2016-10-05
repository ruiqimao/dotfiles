local ret_status="%(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ %s)"

local parent="$(ps -p $PPID -o comm=)"
if [[ $parent == "login" || $parent == "gnome-terminal-" || $parent == "urxvt" || $parent == "tmux: server" ]]; then
	parent=""
else
	parent="%{$fg[cyan]%}${parent} "
fi

PROMPT='${parent}${ret_status}%{$fg_bold[green]%}%p %{$fg[white]%}%c %{$fg_bold[blue]%}$(git_prompt_info)%{$fg_bold[blue]%} % %{$reset_color%}'

ZSH_THEME_GIT_PROMPT_PREFIX="git:(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}✗%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"
