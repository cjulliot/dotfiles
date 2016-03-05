# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
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

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

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
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

export PATH=$PATH:/home/corentin/Programmation/RPI/cross-compilation/x-tools/arm-unknown-linux-gnueabi/bin
export JAVA_HOME=/usr/bin/java

# Fancy schmancy PS1
linecolour='\[\e[0;37m\]'                                                                                                                                                                         
datecolour='\[\e[1;36m\]'                                                                                                                                                                         
if [[ $UID == 0  ]]; then                                                                                                                                                                         
    usercolour='\[\e[1;31m\]';                                                                                                                                                                    
    else                                                                                                                                                                                              
        usercolour='\[\e[1;32m\]';                                                                                                                                                                    
        fi                                                                                                                                                                                                
        hostcolour='\[\e[1;33m\]'                                                                                                                                                                         
        atcolour='\[\e[1;0m\]'                                                                                                                                                                            
        dircolour='\[\e[1;34m\]'                                                                                                                                                                          
        reset='\[\e[0m\]'                                                                                                                                                                                 
        dateformat='%R'                                                                                                                                                                                   
        gitcolour='\e[0;32m'                                                                                                                                                                              
        
        function gitPrompt() {                                                                                                                                                                            
            if [[ -d ".git" ]]; then                                                                                                                                                                      
               echo -e "-[${gitcolour}$(git branch | grep "*" | sed "s/* //")\e[0m]"                                                                                                                     
            fi                                                                                                                                                                                            
         }     

PS1="${linecolour}┌─[${usercolour}\u${atcolour}@${hostcolour}\h${linecolour}]-[${datecolour}\$(date \"+${dateformat}\")${linecolour}]-[${dircolour}\${PWD/#\$HOME/~}${linecolour}]\$(gitPrompt)\n${linecolour}└─>${reset} "      
if [ "$PS1" ]; then
complete -cf sudo
fi

# Fancy schmancy man pages
man() {
       env LESS_TERMCAP_mb=$'\E[01;31m' \
              LESS_TERMCAP_md=$'\E[01;38;5;74m' \
                  LESS_TERMCAP_me=$'\E[0m' \
                      LESS_TERMCAP_se=$'\E[0m' \
                          LESS_TERMCAP_so=$'\E[38;5;246m' \
                              LESS_TERMCAP_ue=$'\E[0m' \
                                  LESS_TERMCAP_us=$'\E[04;38;5;146m' \
                                      man "$@"
    }

