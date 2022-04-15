CURRENT_USER="%{$fg[yellow]%}%n%{$reset_color%}"
CURRENT_USER_ROOT="%{$fg[red]%}%n%{$reset_color%}"

MACHINE="%{$fg_bold[green]%}%m%{$fg[white]%}%{$reset_color%}"

local return_code="%(?..%{$fg[red]%}%? ↵%{$reset_color%})"

if [[ $UID -eq 0 ]]; then
	local user_host='[${CURRENT_USER_ROOT}@${MACHINE}]'
    local user_symbol="%{$fg[red]%}#"
else
    local user_host='[${CURRENT_USER}@${MACHINE}]'
    # local user_symbol='$'
    local user_symbol="%{$fg[green]%}\$"
fi


# ----------------------------------------------------------------------#
#			PROMPT
# ----------------------------------------------------------------------#
local current_dir='[%{$terminfo[bold]$fg[blue]%}%~%{$reset_color%}'
local git_branch='$(git_prompt_info)'
local rvm_ruby='$(ruby_prompt_info)'
local venv_prompt='$(virtualenv_prompt_info)'

ZSH_THEME_RVM_PROMPT_OPTIONS="i v g"

PROMPT="╭─${user_host} ${current_dir}${rvm_ruby}${git_branch}${venv_prompt}]
╰─%B${user_symbol}%b "
RPROMPT="%B${return_code}%b"
# ----------------------------------------------------------------------#


ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[yellow]%} ‹"
ZSH_THEME_GIT_PROMPT_SUFFIX="›%{$reset_color%}"

ZSH_THEME_RUBY_PROMPT_PREFIX="%{$fg[red]%} ‹"
ZSH_THEME_RUBY_PROMPT_SUFFIX="›%{$reset_color%}"

ZSH_THEME_VIRTUAL_ENV_PROMPT_PREFIX="%{$fg[green]%} ‹"
ZSH_THEME_VIRTUAL_ENV_PROMPT_SUFFIX="›%{$reset_color%}"
ZSH_THEME_VIRTUALENV_PREFIX=$ZSH_THEME_VIRTUAL_ENV_PROMPT_PREFIX
ZSH_THEME_VIRTUALENV_SUFFIX=$ZSH_THEME_VIRTUAL_ENV_PROMPT_SUFFIX
