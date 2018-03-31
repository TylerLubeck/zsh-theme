ZSH_THEME_VIRTUAL_ENV_PROMPT_PREFIX="venv:‹%{$fg[red]%}"
ZSH_THEME_VIRTUAL_ENV_PROMPT_SUFFIX="%{$fg[blue]%}› "

ZSH_THEME_USER_PREFIX="%{$fg_bold[red]%}["
ZSH_THEME_USER_SUFFIX="]%{$reset_color%}"

ZSH_THEME_GIT_PREFIX="%{$fg[yellow]%}[git:<"
ZSH_THEME_GIT_SUFFIX=">]%{$reset_color%}"
ZSH_THEME_GIT_DIRTY="%{$fg[yellow]%}✗%{$reset_color%}"
ZSH_THEME_GIT_CLEAN="%{$fg[blue]%}"
ZSH_THEME_VIRTUALENV_PREFIX="%{$fg[blue]%}["
ZSH_THEME_VIRTUALENV_SUFFIX="]%{$reset_color%}"

ZSH_THEME_PATH="%{$fg[cyan]%}%~%{$reset_color%}"

function _virtualenv_prompt_info {
    if [[ ! -z $VIRTUAL_ENV ]]; then
        local ENV="py:${VIRTUAL_ENV}"
    fi

    # TODO: ruby env, gopath, other languages?

    if [[ ! -z $ENV ]]; then
        echo "$ZSH_THEME_VIRTUALENV_PREFIX${ENV:t}$ZSH_THEME_VIRTUALENV_SUFFIX"
    fi
}

function _username_prompt_info {
    [[ $USER != 'tyler' ]] && echo "$ZSH_THEME_USER_PREFIX${USER:t}$ZSH_THEME_USER_SUFFIX"
}

_git_prompt_info () {
        local ref
        if [[ "$(command git config --get zsh_prompt.hide-status 2>/dev/null)" != "1" ]]
        then
                ref=$(command git symbolic-ref HEAD 2> /dev/null)  || ref=$(command git rev-parse --short HEAD 2> /dev/null)  || return 0
                echo "$ZSH_THEME_GIT_PREFIX${ref#refs/heads/}$ZSH_THEME_GIT_SUFFIX "
        fi
}

PROMPT='$(_username_prompt_info)$(_virtualenv_prompt_info)$(_git_prompt_info)$ZSH_THEME_PATH
➜ '
