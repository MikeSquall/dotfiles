# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/michael/.oh-my-zsh"

ZSH_THEME="powerlevel9k/powerlevel9k"
POWERLEVEL9K_MODE="nerdfont-complete"

POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_PROMPT_ADD_NEWLINE_COUNT=1
POWERLEVEL9K_DISABLE_RPROMPT=false
POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="╰▶ "
POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX="╭"
POWERLEVEL9K_SHORTEN_DIR_LENGTH=2

POWERLEVEL9K_CUSTOM_INTERNET_SIGNAL="zsh_internet_signal"

POWERLEVEL9K_TIME_FORMAT="%D{%d.%m.%y   %H:%M:%S}"

POWERLEVEL9K_COMMAND_EXECUTION_TIME_THRESHOLD=0

POWERLEVEL9K_CUSTOM_DISTRO_ICON="echo  "
POWERLEVEL9K_CUSTOM_DISTRO_BACKGROUND=208
POWERLEVEL9K_DIR_HOME_BACKGROUND='dodgerblue1'
POWERLEVEL9K_DIR_HOME_SUBFOLDER_BACKGROUND='skyblue2'
POWERLEVEL9K_USER_DEFAULT_BACKGROUND='purple4'
POWERLEVEL9K_USER_DEFAULT_FOREGROUND='aquamarine1'

POWERLEVEL9K_DIR_PATH_SEPARATOR="%F{black}  %F{black}"

POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(custom_distro_icon dir vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(command_execution_time status virtualenv node_version user time)

# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  yarn
  virtualenv
)

source $ZSH/oh-my-zsh.sh


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export PATH="$PATH: 'yarn global bin'"

alias matrix='LC_ALL=C tr -c "[:digit:]" " " < /dev/urandom | dd cbs=$COLUMNS conv=unblock | GREP_COLOR="1;32" grep --color "[^ ]"'

# added by travis gem
[ -f /home/michael/.travis/travis.sh ] && source /home/michael/.travis/travis.sh

# setup custom variables
export GH_TOKEN=$(cat /home/michael/Documents/gh_tok)

# add custom scripts
export PATH="$PATH: ~/.local/bin/"

# custom git aliases
alias amend='git commit --amend'

# find used ports (except root used ports)
alias ports='lsof -i -P -n | grep LISTEN'

# cool command to play sound
alias finished='paplay /home/michael/Music/aoe/villagercreation.wav'
alias failed='paplay /home/michael/Music/aoe/attackwarning.wav'
alias applause='paplay /home/michael/Music/applause7.wav'

# Go path variables
export GOROOT=/usr/local/go
export GOPATH=$HOME/go
export PATH=$GOPATH/bin:$GOROOT/bin:$PATH

# Kubernetes
export KUBECONFIG=$HOME/.kube/config

