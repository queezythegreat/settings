# /etc/skel/.bashrc
#
# This file is sourced by all *interactive* bash shells on startup,
# including some apparently interactive shells such as scp and rcp
# that can't tolerate any output.  So make sure this doesn't display
# anything or bad things will happen !


# Test for an interactive shell.  There is no need to set anything
# past this point for scp and rcp, and it's important to refrain from
# outputting anything in those cases.
if [[ $- != *i* ]] ; then
    # Shell is non-interactive.  Be done now!
    return
fi


# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

#========================================#
#                                        #
#               Aliases                  #
#                                        #
#========================================#
    # Vim Aliases
    alias vi=vim
    alias vim='vim -p'
    
    # ls aliases
    alias ls="ls --color"
    alias s='ls'
    alias l='ls -l'
    
    # clear alias
    alias c='clear'

    # SVN aliases
    alias sa='svn add'
    alias srm='svn rm'
    alias scom='svn commit'
    alias sout='svn checkout'
    alias sex='svn export'
    alias sim='svn import'
    alias spe='svn propedit'
    alias sup='svn update'
    alias ss='svn status'
    alias sls='svn ls'
    alias smv='svn mv'
    alias sdiff='svn diff'
    alias smkdir='svn mkdir'

    # BZR aliases
    alias bs='bzr status'
    alias bi='bzr info'
    alias bl='bzr log'

    alias ba='bzr add'
    alias bmv='bzr mv'
    alias bmkdir='bzr mkdir'

    alias bmerge='bzr merge'
    alias bdiff='bzr diff'

    alias bpull='bzr pull'
    alias bpush='bzr push'
    alias bcom='bzr commit'
    alias bb='bzr branch'

    alias bql='bzr qlog'
    alias bqb='bzr qblame'
    alias bqm='bzr qmerge'

    # cd aliases
    alias ..='cd ..'
    alias sbuild="ssh tomek@build"

    #
    alias vspace_dev="svn co svn+ssh://build/nc/linux/trunk"
    alias vspace_stable="svn co svn+ssh://build/nc/linux/stable"
    alias xseries="svn co svn+ssh://build/nc/linux/branches/xseries"



#========================================#
#                                        #
#         Enviroment Variables           #
#                                        #
#========================================#
    PATH="$PATH:~/:~/bin/:."
    EDITOR="/usr/bin/vim"

    # Set the screen title
    case $TERM in
        screen*)
            # This is the escape sequence ESC k \w ESC \
            PS1="\[\033[01;32m\][\u@\h\[\033[01;34m\] \W]\[\033[00m\]\[\ek\e\\ \]"
            ;;
        *)
            SCREENTITLE=""
            ;;
    esac



    export PS1 PATH EDITOR

#========================================#
#                                        #
#          Artemis Settings              #
#                                        #
#========================================#
    if [ "$HOSTNAME" = "artemis" ]; then
        
        if [ "$TERM" = "xterm" ]; then
            TERM="screen-256color"
        fi
        
        if [ -z $SCREEN_STARTED ]; then
            SCREEN_STARTED="yes"
            export SCREEN_STARTED
        fi
        
        HISTSIZE=100
        LC_ALL=C
        LANG="en_US"
        
        EDITOR="vim"
        SVN_EDITOR="vim"
        
        PS1="[\u@\[\033[0;31m\]Artemis\[\033[0;39m\] \w] "
        
        export LANG PS1 TERM EDITOR SVN_EDITOR LC_ALL
    fi





