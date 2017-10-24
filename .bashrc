export WORKON_HOME=/home/michael/virtualenv
export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python2.7
source /home/michael/.local/bin/virtualenvwrapper.sh
# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=10000
HISTFILESIZE=20000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

DEFAULT="[0m"
BLINK="[5m"
BLINKRESET="[25m"

WHITE="[37m"
PINK="[30m"
LIGHTBLUE="[36m"
RED="[31m"
GREEN="[32m"
YELLOW="[01;33m"
BLUE="[34m"

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alFh'
alias la='ls -A'
alias l='ls -CF'
alias faq='cd ~/faq'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# default editor
export EDITOR="vim"

_get_project_path() {
    local PROJECT_PATH
    PROJECT_PATH=$(cat "$VIRTUAL_ENV"/.project 2> /dev/null)
    if [ "$PROJECT_PATH" = "" ] || [ ! -d "$PROJECT_PATH" ]; then
        if [ -z "$VIRTUAL_ENV" ]; then
            PROJECT_PATH=
        else
            PROJECT_PATH=$VIRTUAL_ENV
        fi
    fi
    echo $PROJECT_PATH
}

tryton_db_ps1() {
    local PROJECT_PATH
    PROJECT_PATH=$(_get_project_path)
    if [ ! "$PROJECT_PATH" = "" ] && [ -f "$PROJECT_PATH"/conf/trytond.conf ]; then
        DB_NAME=$(cat "$PROJECT_PATH"/conf/trytond.conf | grep "^uri = postgres" | sed -e "s/.*@[^:]\+:[0-9]\+\/\?//")
        if [ ! "$DB_NAME" = "" ] && [ ! "$DB_NAME" == "uri = *" ]; then
            echo " -> $DB_NAME "
        fi
    fi
}

# Add git branch if its present to PS1
parse_git_branch() {
 git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}
PS1='\e[92m\D{%T} ${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[01;31m\]$(parse_git_branch)\[\033[00m\]\[\033[01;33m\]$(tryton_db_ps1)\[\033[00m\n\$ '

#alias coog
alias restart_server='coog server kill && sleep 1 && coog server start'
alias restart_client='coog client kill && sleep 1 && coog client start'
alias restart_coog='coog kill && sleep 1 && coog start'
alias cst="coog server tail -f | grep --line-buffered -vIE '(DEBUG|INFO)'"
alias cstd="coog server tail -f"

#alias tryton
alias trytondstart='trytond -c conf/trytond.conf'

#alias libreoffice 4.2
alias writer42='./LibreOffice_4.2.8.2_Linux_x86-64_deb/DEBS/install/opt/libreoffice4.2/program/swriter'

#alias new tab with guake
alias tab='guake -n guake -r '

#alias git
alias diff_master='git diff $(git merge-base HEAD origin/master) HEAD'

#alias docker
alias ip_container="docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}'"

export PATH=$PATH:/home/michael/bin

