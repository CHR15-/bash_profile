# Return early if not an interactive shell
[ -z "$PS1" ] && return

# Git prompt
source ~/.git-prompt.sh
export GIT_PS1_SHOWDIRTYSTATE=1

# Define custom prompt
DEFAULT_COLOR="\[\033[0;33m\]"
CYAN_COLOR="\[\033[36m\]"
PINK_COLOR="\[\033[35m\]"
GREEN_COLOR="\[\033[32m\]"
ORANGE_COLOR="\[\033[33m\]"
RED_COLOR="\[\033[31m\]"
WHITE_COLOR="\[\033[1;32m\]"

# Git autocompletion
if [ -f /usr/share/bash-completion/completions/git ]; then
    source /usr/share/bash-completion/completions/git
elif [ -f ~/.git-completion.bash ]; then
    source ~/.git-completion.bash
else
    curl -o ~/.git-completion.bash https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash
    source ~/.git-completion.bash
fi

# Enable bash completion if available
if [ -f /usr/local/etc/bash_completion ]; then
    . /usr/local/etc/bash_completion
elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

# Function to display compact path
__pwd() {
    WORKING_DIR=$(pwd)
    PARENT_DIR=$(dirname "$WORKING_DIR")

    if [ "$WORKING_DIR" = "/" ]; then
        echo "/"
    else
        if [ "$PARENT_DIR" = "/" ]; then
            echo "$(basename "$WORKING_DIR")"
        else
            echo "$(basename "$PARENT_DIR")/$(basename "$WORKING_DIR")"
        fi
    fi
}

# SSH Indicator
__ssh() {
    [ -n "$SSH_CLIENT" ] && echo '*** '
}

# Prompt format
export BASEPROMPT="\n${RED_COLOR}\$(__ssh)\u \
${CYAN_COLOR}at ${ORANGE_COLOR}\h \
${CYAN_COLOR}in ${WHITE_COLOR}\$(__pwd)\
\$(__git_ps1 \" ${CYAN_COLOR}on ${PINK_COLOR}git:%s\")${DEFAULT_COLOR}"

export PS1="${BASEPROMPT}\n\$ "

# Colored `ls`
export CLICOLOR=1

# Add ~/bin directory to PATH
export PATH=~/bin:$PATH

# Add Flutter bin to PATH
export PATH=$HOME/Users/chris/flutter/bin:$PATH

# Add GO and Java to PATH
export GOPATH=~/go
export PATH=$PATH:$GOPATH/bin

export JAVA_HOME=$(/usr/libexec/java_home -v 11)
export PATH=$JAVA_HOME/bin:$PATH

# NVM (Node Version Manager)
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # Load nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # Load nvm bash completion

# RVM (Ruby Version Manager) and rbenv setup
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

# Bash completion setup
if which brew &> /dev/null; then
    if [ -f "$(brew --prefix)/etc/bash_completion" ]; then
        . "$(brew --prefix)/etc/bash_completion"
    fi
elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

# aliases
alias ll='ls -lah'
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gd='git diff'
alias gco='git checkout'
alias gl='git log --oneline --graph --decorate'
alias ..='cd ..'
alias reload='source ~/.bash_profile'
alias c='clear'
alias edit='code .'

HISTSIZE=10000
HISTFILESIZE=20000
HISTCONTROL=ignoredups:erasedups  # Ignore dups
shopt -s histappend

# Export additional PATHs
export PATH=/usr/local/bin:/usr/local/sbin:/Developer/usr/bin:/usr/local/mysql/bin:$PATH