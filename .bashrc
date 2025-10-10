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
alias vim="hx"
alias mount="mount | column -t"
alias ping="ping -c 5"
alias df="df -H"
alias du="du -ch"
alias top="btop"
alias hx="helix"

# Custom prompt.
RESET_COLORS="\[\033[00m\]"
COLOR_START="\[\033["
FG="38;2;"
BG="48;2;"
COLOR_END="m\]"
COLOR_FG="$COLOR_START$FG"
COLOR_BG="$COLOR_START$BG"
COLOR_TEXT="30;30;46"
COLOR_NAME="129;161;193"
COLOR_DIRECTORY="136;192;208"
COLOR_GIT="208;135;112"
TEXT="$COLOR_FG$COLOR_TEXT$COLOR_END"
NAME_BG="$COLOR_BG$COLOR_NAME$COLOR_END"
NAME_FG="$COLOR_FG$COLOR_NAME$COLOR_END"
DIRECTORY_BG="$COLOR_BG$COLOR_DIRECTORY$COLOR_END"
DIRECTORY_FG="$COLOR_FG$COLOR_DIRECTORY$COLOR_END"
GIT_BG="$COLOR_BG$COLOR_GIT$COLOR_END"
GIT_FG="$COLOR_FG$COLOR_GIT$COLOR_END"


build_prompt() {
    branch_name=$(git branch --no-color 2> /dev/null | tr -d "*")
    PS1="$NAME_FG$NAME_BG $TEXT󰌢 \u@\H $DIRECTORY_BG$NAME_FG$DIRECTORY_BG $TEXT \w "
    if [[ -n $branch_name ]]; then
        branch_status=$(git status --porcelain 2> /dev/null)
        PS1+="$DIRECTORY_FG$GIT_BG$TEXT $branch_name "
        if [[ -n $branch_status ]]; then
            PS1+=" "
        fi
        PS1+="$RESET_COLORS$GIT_FG$RESET_COLORS "
    else
        PS1+="$RESET_COLORS$DIRECTORY_FG$RESET_COLORS "
    fi
}

export PROMPT_COMMAND=build_prompt

# Rust environment change
. "$HOME/.cargo/env"

export EDITOR=/usr/bin/helix

unset rc

fastfetch

