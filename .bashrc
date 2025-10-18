# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:$HOME/.local/sbin" ]]; then
    PATH="$HOME/.local/bin:$HOME/bin:$HOME/.local/sbin:$PATH"
fi
export PATH

export LANG="en_GB.UTF-8"
LC_CTYPE="en_GB.UTF-8"
LC_NUMERIC="en_GB.UTF-8"
export LC_ALL="en_GB.UTF-8"

export FZF_DEFAULT_OPTS='--layout=reverse --height=40% --info=inline --border'

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
    for rc in ~/.bashrc.d/*; do
        if [ -f "$rc" ]; then
            . "$rc"
        fi
    done
fi

# A few handy aliases
alias ll="ls -al --color=auto"
alias grep="grep --color=auto"
alias mkdir="mkdir -pv"
alias diff="colordiff"
alias vim="nvim"
alias mount="mount | column -t"
alias ping="ping -c 5"
alias df="df -H"
alias du="du -ch"
alias top="btop"
alias cp="cp -i"
alias mv="mv -i"
alias hx="helix"

# Custom prompt.
RESET_COLORS="\[\033[00m\]"
RESET_BG_COLOR="\[\033[49m\]"
COLOR_START="\[\033["
COLOR_END="m\]"
FG="38;2;"
BG="48;2;"

COLOR_TEXT="30;30;46"
COLOR_NAME="129;161;193"
COLOR_DIRECTORY="136;192;208"
COLOR_GIT="208;135;112"
COLOR_VENV="76;86;106"

TEXT="${COLOR_START}${FG}${COLOR_TEXT}${COLOR_END}"
NAME_BG="${COLOR_START}${BG}${COLOR_NAME}${COLOR_END}"
NAME_FG="${COLOR_START}${FG}${COLOR_NAME}${COLOR_END}"
VENV_TEXT="${COLOR_START}${FG}${COLOR_VENV}${COLOR_END}"
DIRECTORY_BG="${COLOR_START}${BG}${COLOR_DIRECTORY}${COLOR_END}"
DIRECTORY_FG="${COLOR_START}${FG}${COLOR_DIRECTORY}${COLOR_END}"
GIT_BG="${COLOR_START}${BG}${COLOR_GIT}${COLOR_END}"
GIT_FG="${COLOR_START}$FG${COLOR_GIT}${COLOR_END}"

TEXT="\[\033[38;2;30;30;46m\]"
NAME_BG="\[\033[48;2;129;161;193m\]"
NAME_FG="\[\033[38;2;129;161;193m\]"
VENV_TEXT="\[\033[38;2;76;86;106m\]"
DIRECTORY_BG="\[\033[48;2;136;192;208m\]"
DIRECTORY_FG="\[\033[38;2;136;192;208m\]"
GIT_BG="\[\033[48;2;208;135;112m\]"
GIT_FG="\[\033[38;2;208;135;112m\]"

# Function to get the current Python virtual environment name
get_venv_name() {
    # Check if the VIRTUAL_ENV variable is set
    if [[ -n "$VIRTUAL_ENV" ]]; then
        # Use basename to extract the directory name (the venv name)
        local venv_name="$(basename "$VIRTUAL_ENV_PROMPT")"
        
        # Strip a single leading dot if it exists
        if [[ "$venv_name" =~ ^\. ]]; then
            # Uses parameter expansion: ${variable#pattern} to remove the shortest 
            # match of 'pattern' from the front of 'variable'
            echo "${venv_name#.}"
        else
            echo "$venv_name"
        fi
    fi
}

build_prompt() {
    local venv_name=$(get_venv_name)
    local branch_name=$(git branch --no-color 2> /dev/null | tr -d "*")

    PS1="${NAME_FG}${NAME_BG} ${TEXT}󰌢 \u@\H "
    PS1+="${DIRECTORY_BG}${NAME_FG}"
    if [[ -n $venv_name ]]; then
        PS1+=" ${TEXT}[${VENV_TEXT}$venv_name${TEXT}]"
    fi
    PS1+=" ${TEXT} \w "
    if [[ -n $branch_name ]]; then
        branch_status=$(git status --porcelain 2> /dev/null)
        PS1+="${DIRECTORY_FG}${GIT_BG}${TEXT} $branch_name "
        if [[ -n $branch_status ]]; then
            PS1+=" "
        fi
        PS1+="${RESET_BG_COLOR}${GIT_FG}${RESET_COLORS} "
    else
        PS1+="${RESET_BG_COLOR}${DIRECTORY_FG}${RESET_COLORS} "
    fi
}

export PROMPT_COMMAND=build_prompt

# Rust environment change
. "$HOME/.cargo/env"

export EDITOR=/usr/bin/nvim

unset rc

fastfetch

# >>> FZF integration added below <<<

# Check if fzf is installed and source the key bindings and completion scripts.
if [ -f /usr/share/fzf/key-bindings.bash ]; then
    . /usr/share/fzf/key-bindings.bash
fi

if [ -f /usr/share/fzf/completion.bash ]; then
    . /usr/share/fzf/completion.bash
fi
