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

# jj prompt

_jj_workspace_root() {
	local dir=$PWD
	while [[ $dir != / && ! -d $dir/.jj ]]; do
		dir=${dir:h}
	done
	if [[ -d $dir/.jj ]]; then
		printf '%s' "$dir"
		return 0
	fi
	return 1
}

jj_prompt_info() {
	(( $+commands[jj] )) || return 0
	_jj_workspace_root >/dev/null || return 0

  # info format: <name>|<empty>|<conflict>
	# <name> is either the bookmark or the first letter of its change ID.
	local info
	info=$(jj --color never log --no-graph -r @ -T 'try(local_bookmarks.first().name(), change_id.shortest()) ++ "|" ++ self.empty() ++ "|" ++ self.conflict()' 2>/dev/null) || return 0

	local name=${info%%|*}
	local rest=${info#*|}
	local empty=${rest%%|*}
	local conflict=${rest##*|}

	local state=$ZSH_THEME_JJ_PROMPT_CLEAN
	if [[ $empty == false || $conflict == true ]]; then
		state=$ZSH_THEME_JJ_PROMPT_DIRTY
	fi

	printf '%s%s%s%s' "$ZSH_THEME_JJ_PROMPT_PREFIX" "$name" "$state" "$ZSH_THEME_JJ_PROMPT_SUFFIX"
}

ZSH_THEME_JJ_PROMPT_PREFIX="jj:(%{$fg[red]%}"
ZSH_THEME_JJ_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_JJ_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}✗%{$reset_color%}"
ZSH_THEME_JJ_PROMPT_CLEAN="%{$fg[blue]%})"

# Override git_prompt_info to show jj prompt instead if jj repository is present.
if [[ -z $_OMZ_JJ_PROMPT_LOADED ]] && (( ${+functions[git_prompt_info]} )); then
	functions[_omz_git_prompt_info_orig]=$functions[git_prompt_info]
	function git_prompt_info() {
		if _jj_workspace_root >/dev/null; then
			jj_prompt_info
		else
			_omz_git_prompt_info_orig
		fi
	}
	_OMZ_JJ_PROMPT_LOADED=1
fi
