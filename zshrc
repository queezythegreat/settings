# The following lines were added by compinstall

#zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
#zstyle ':completion:*' matcher-list 'm:{[:lower:]}={[:upper:]}'
#zstyle :compinstall filename '/home/queezy/.zshrc'
#
#autoload -Uz compinit
#compinit
## End of lines added by compinstall
## Lines configured by zsh-newuser-install
#HISTFILE=~/.histfile
#HISTSIZE=10000
#SAVEHIST=10000
#setopt appendhistory autocd extendedglob notify
#unsetopt beep nomatch
bindkey -e
# End of lines configured by zsh-newuser-install
######################################################################
#		      mako's zshrc file, v0.12
#
# 
######################################################################

# next lets set some enviromental/shell pref stuff up
# setopt NOHUP
#setopt NOTIFY
#setopt NO_FLOW_CONTROL
setopt APPEND_HISTORY
setopt NO_AUTO_MENU
# setopt AUTO_LIST		# these two should be turned off
# setopt AUTO_REMOVE_SLASH
# setopt AUTO_RESUME		# tries to resume command of same name
unsetopt BG_NICE		# do NOT nice bg commands
setopt CORRECT			# command CORRECTION
setopt EXTENDED_HISTORY		# puts timestamps in the history
setopt HASH_CMDS		# turns on hashing

setopt ALL_EXPORT

TZ="Europe/Rome"

HISTFILE=$HOME/.zhistory
HISTSIZE=10000
SAVEHIST=10000

HOSTNAME="`hostname`"
NNTPSERVER=wonka.hampshire.edu
#NNTPSERVER=netnews.attbi.com
PAGER=less
EDITOR='vim'
#EMAIL='mako@bork.hampshire.edu'
#DEBFULLNAME="Benjamin Hill (Mako)" 
DEBEMAIL='mako@debian.org'
CVS_RSH=ssh
# CVSROOT=/var/cvs
CVSROOT=:ext:mako@micha.hampshire.edu:/var/cvs
# PROMPT="$HOST:%~%% " 
PS1='%D{%m%d %H:%M} %U%m%u:%2c%# '


PYTHON_PATH="python-libs:$PYTHON_PATH"
CPATH="$HOME/bin:/usr/local/bin:/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/sbin:/usr/X11R6/bin:/usr/games:."
echo ${PATH} | grep -q "${CPATH}" || export PATH="$CPATH:$PATH"


#LANGUAGE=
#LC_ALL=en_US.UTF-8
#LANG=en_US.UTF-8
#LC_CTYPE=C

export LANG=en_US.utf8
export LC_ALL=
export LC_COLLATE="C"


unsetopt ALL_EXPORT
# --------------------------------------------------------------------
# aliases
# --------------------------------------------------------------------

#eval `dircolors $HOME/.dircolors`
eval `dircolors`
alias slrn="slrn -n"
alias f=finger
alias ll='ls -al'
alias ls='ls --color=auto '
alias offlineimap-tty='offlineimap -u TTY.TTYUI'
alias rest2html-css='rest2html --embed-stylesheet --stylesheet-path=/usr/share/python-docutils/stylesheets/default.css'

#alias clear="print -n "
alias c=clear
alias cl=clear
alias cls=clear
alias =clear


alias tmux="tmux -2"

#chpwd() {
#     [[ -t 1 ]] || return
#     case $TERM in
#     sun-cmd) print -Pn "\e]l%~\e\\"
#     ;;
#    *xterm*|screen|rxvt|(dt|k|E)term) print -Pn "\e]2;%~\a"
#    ;;
#    esac
#}

#chpwd
zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
zstyle ':completion:*' matcher-list 'm:{[:lower:]}={[:upper:]}'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
#zstyle ':completion:*' list-prompt '%SAt %p: Hit TAB for more, or the character to insert%s'
#zstyle ':completion:*' menu select=5
#zstyle ':completion:*' select-prompt '%SScrolling active: current selection at %p%s'

zstyle ':completion:*' menu select=2
zstyle ':completion:*' group-name ''
zstyle ':completion:*' ignore-parents pwd parent ..
zstyle ':completion:*' remove-all-dups true
zstyle ':completion:*' select-scroll 1
zstyle ':completion:*' special-dirs '..'
zstyle ':completion:*' use-cache yes
#  zstyle ':completion:*' cache-path $ZDOTDIR/cache
zstyle ':completion::complete:*' cache-path $ZSHDIR/cache/$HOST
zstyle ':completion:*' insert-unambiguous true
zstyle ':completion:*' range 200:20
zstyle ':completion:*' select-prompt '%SSelect:  lines: %L  matches: %M  [%p]'
zstyle ':completion:*' keep-prefix changed

autoload -U compinit
compinit




function precmd {

    local TERMWIDTH
    (( TERMWIDTH = ${COLUMNS} - 1 ))


    ###
    # Truncate the path if it's too long.
    
    PR_FILLBAR=""
    PR_PWDLEN=""
    
    local promptsize=${#${(%):---(%n@%m)---()--}}
    local pwdsize=${#${(%):-%~}}
    
    if [[ "$promptsize + $pwdsize" -gt $TERMWIDTH ]]; then
	    ((PR_PWDLEN=$TERMWIDTH - $promptsize))
    else
	PR_FILLBAR="\${(l.(($TERMWIDTH - ($promptsize + $pwdsize)))..${PR_HBAR}.)}"
    fi


}


setopt extended_glob
preexec () {
    if [[ "$TERM" == "screen" ]]; then
	local CMD=${1[(wr)^(*=*|sudo|-*)]}
	echo -n "\ek$CMD\e\\"
    fi
}


setprompt () {
    ###
    # Need this so the prompt will work.

    setopt prompt_subst


    ###
    # See if we can use colors.

    autoload colors zsh/terminfo
    if [[ "$terminfo[colors]" -ge 8 ]]; then
	colors
    fi
    for color in RED GREEN YELLOW BLUE MAGENTA CYAN WHITE; do
	eval PR_$color='%{$terminfo[bold]$fg[${(L)color}]%}'
	eval PR_LIGHT_$color='%{$fg[${(L)color}]%}'
	(( count = $count + 1 ))
    done
    PR_NO_COLOUR="%{$terminfo[sgr0]%}"

    for color in RED GREEN YELLOW BLUE MAGENTA CYAN WHITE; do
	eval PR_BG_$color='%{$terminfo[bold]$bg[${(L)color}]%}'
	eval PR__BG_LIGHT_$color='%{$bg[${(L)color}]%}'
	(( count = $count + 1 ))
    done

    ###
    # See if we can use extended characters to look nicer.
    
    typeset -A altchar
    set -A altchar ${(s..)terminfo[acsc]}
    PR_SET_CHARSET="%{$terminfo[enacs]%}"
    PR_SHIFT_IN="%{$terminfo[smacs]%}"
    PR_SHIFT_OUT="%{$terminfo[rmacs]%}"
    PR_HBAR=${altchar[q]:--}
    PR_ULCORNER=${altchar[l]:--}
    PR_LLCORNER=${altchar[m]:--}
    PR_LRCORNER=${altchar[j]:--}
    PR_URCORNER=${altchar[k]:--}

    
    ###
    # Decide if we need to set titlebar text.
    
    case $TERM in
	xterm*)
	    PR_TITLEBAR=$'%{\e]0;%(!.-=*[ROOT]*=- | .)%n@%m:%~ | ${COLUMNS}x${LINES} | %y\a%}'
	    ;;
	screen)
	    PR_TITLEBAR=$'%{\e_screen \005 (\005t) | %(!.-=[ROOT]=- | .)%n@%m:%~ | ${COLUMNS}x${LINES} | %y\e\\%}'
	    ;;
	*)
	    PR_TITLEBAR=''
	    ;;
    esac
    
    
    ###
    # Decide whether to set a screen title
    if [[ "$TERM" == "screen" ]]; then
	PR_STITLE=$'%{\ekzsh\e\\%}'
    else
	PR_STITLE=''
    fi
    
    
    
	PR_APM=''
    
    ###
    # Finally, the prompt.
    LINE_COLOR="${PR_BLUE}"
    USER_COLOR="${PR_GREEN}"
    HOST_COLOR="${PR_RED}"
    CWD_COLOR="${PR_GREEN}"
    EXIT_CODE_COLOR="$PR_LIGHT_RED"

    UL_CORNER='${LINE_COLOR}${PR_SHIFT_IN}${PR_ULCORNER}${PR_HBAR}${PR_SHIFT_OUT}'
    UR_CORNER='${LINE_COLOR}${PR_SHIFT_IN}${PR_HBAR}${PR_URCORNER}${PR_SHIFT_OUT}'
    LL_CORNER='${LINE_COLOR}${PR_SHIFT_IN}${PR_LLCORNER}${PR_HBAR}${PR_SHIFT_OUT}'
    LR_CORNER='${LINE_COLOR}${PR_SHIFT_IN}${PR_HBAR}${PR_LRCORNER}${PR_SHIFT_OUT}'
    FILLER='${LINE_COLOR}${PR_SHIFT_IN}${(e)PR_FILLBAR}${PR_HBAR}${PR_SHIFT_OUT}'

    USER_HOST='${USER_COLOR}%(!.%SROOT%s.%n)${HOST_COLOR}@%m'
    CURRENT_WD='${CWD_COLOR}%${PR_PWDLEN}<...<%~%<<'
    EXIT_CODE='%(?..${LINE_COLOR}[${EXIT_CODE_COLOR}%?${LINE_COLOR}] )'
    #CURRENT_TIME='${(e)PR_APM}$PR_YELLOW%D{%H:%M}$PR_LIGHT_BLUE:%(!.$PR_RED.$PR_WHITE)%#'
    CURRENT_TIME='${(e)PR_APM}$PR_YELLOW%D{%H:%M}$PR_LIGHT_BLUE'
    CURRENT_DATE='$PR_YELLOW%D{%a,%b%d}$PR_BLUE'

    SEPERATOR='${LINE_COLOR}$PR_SHIFT_IN$PR_HBAR$PR_HBAR$PR_SHIFT_OUT'
    CMD_CONTINUATION='$PR_LIGHT_GREEN%_'

    SET_TITLEBAR='$PR_SET_CHARSET$PR_STITLE${(e)PR_TITLEBAR}'
    JOBS='$(job_name)$(job_count)'

    PROMPT="${SET_TITLEBAR}$UL_CORNER $USER_HOST ${SEPERATOR} $CURRENT_WD $FILLER$UR_CORNER\

$LL_CORNER$PR_NO_COLOUR "

    RPROMPT=" $EXIT_CODE$LL_CORNER%\[${JOBS}${CURRENT_DATE} $CURRENT_TIME\${LINE_COLOR}%\]${LR_CORNER}${PR_NO_COLOUR}"

    PS2="${SEPERATOR}(${CMD_CONTINUATION}${PR_BLUE})${SEPERATOR}${PR_NO_COLOUR} "
}

job_name() {
    JOB_LENGTH=$((${COLUMNS}-70))
    if [ "${JOB_LENGTH}" -lt "0" ];then
        JOB_LENGTH=0
    fi
    echo $JOB_LENGTH > /tmp/test
    JOB_NAME=$(jobs|grep +|tr -s " "|cut -d " " -f 4-|cut -b 1-${JOB_LENGTH}|sed "s/\(.*\)/\1:/")
    echo "${PR_GREEN}${JOB_NAME}"
}
job_count() {
    local JOB_COUNT
    JOB_COUNT=$(jobs|wc -l)
    if [ "${JOB_COUNT}" -gt 0 ]; then
        echo "${PR_RED}${JOB_COUNT}${PR_LIGHT_BLUE}|"
    fi
}

setprompt

# parse_path ARG_NUM ARGS
#
# Parses off an optional path, and saves it in CURRENT_PATH.
# The path must be the first argument of the argument list.
# Parsing of path is done based on the argument count.
#
# returns Amount of argument to shift off
function parse_path {
    if [ $# -gt 0 ]; then
        ARG_MIN="$1"
        ARG_NUM="$(( ${ARG_MIN} + 1 ))"
        shift
        
        if [ $# -ge ${ARG_MIN} ]; then
            # Update/Set path
            if [ $# -ge ${ARG_NUM} -a ! -z $1 -a  -d $1 ]; then
                # New path supplied, saving, one to shift off
                echo Setting new path
                CURRENT_PATH="$1"
                export CURRENT_PATH
                return 1
            elif [ $# -eq ${ARG_NUM} -a ! -d $1 ]; then
                print "Invalid path: \"$1\""
                return -1
            elif [ $# -ge ${ARG_MIN} -a ! -d "${CURRENT_PATH}" ]; then
                print "Invalid current path: CURRENT_PATH=\"${CURRENT_PATH}\""
                return -1
            fi
        
            if [ -d "${CURRENT_PATH}" ]; then
                # No new path supplied, nothing to shift off
                return 0
            fi
        fi
    fi
    
    # Something went wrong
    #echo "$0 ARG_NUM [PATH] ARGS"
    return -1
}

function ffile {
    parse_path 1 $@
    SHIFT_OFF="$?"
    if [ ${SHIFT_OFF} -eq -1 ]; then
        print "$0 [PATH] file_regex"
        return 1
    else
        shift ${SHIFT_OFF}
        find ${CURRENT_PATH} -type f -iname $1
    fi
}

# gfiles grep_regex path
function gfiles {
    parse_path 1 $@
    SHIFT_OFF="$?"
    if [ ${SHIFT_OFF} -eq -1 ]; then
        print "$0 [PATH] regex"
        return 1
    else
        shift ${SHIFT_OFF}
        find ${CURRENT_PATH} -name .svn -prune -o -type f -exec grep -Hn --color $1 {} \;
    fi
}

# gheaders grep_regex path
function gheaders {
    parse_path 1 $@
    SHIFT_OFF="$?"
    if [ ${SHIFT_OFF} -eq -1 ]; then
        print "$0 [PATH] regex"
        return 1
    else
        shift ${SHIFT_OFF}
        find ${CURRENT_PATH} -name .svn -prune -o -type f \( -iname '*.h' -o -iname '*.hpp' \) -exec grep -Hn --color $1 {} \;
    fi
}

# gsources grep_regex path
function gsources {
    parse_path 1 $@
    SHIFT_OFF="$?"
    if [ ${SHIFT_OFF} -eq -1 ]; then
        print "$0 [PATH] regex"
        return 1
    else
        shift ${SHIFT_OFF}
        find ${CURRENT_PATH} -name .svn -prune -o -type f \( -iname '*.c' -o -iname '*.cpp' -o -iname '*.cxx' \) -exec grep -Hn --color $1 {} \;
    fi
}

# gcmakes grep_regex path
function gcmakes {
    parse_path 1 $@
    SHIFT_OFF="$?"
    if [ ${SHIFT_OFF} -eq -1 ]; then
        print "$0 [PATH] regex"
        return 1
    else
        shift ${SHIFT_OFF}
        find ${CURRENT_PATH} -name .svn -prune -o -type f -iname '*.cmake' -exec grep -Hn --color $1 {} \;
    fi
}

#ireplace ~src 'nclogging.h' 'nclog\/\1'
function inc_replace {
    find $1  -name .svn -prune -o -type f \( -iname '*.h' -o -iname '*.hpp' -o -iname '*.cpp' -o -iname '*.c' -o -iname '*.cxx'  \) -a \
       -exec egrep -q "^#include +\"$2\" *" {} \; \
       -exec sed -r -i.bak "s/^#include +\"($2)\" */#include <$3>/" {} \; -print
}

function replace_sed {
    find $1  -name .svn -prune -o -type f \( -iname '*.h' -o -iname '*.hpp' -o -iname '*.cpp' -o -iname '*.c' -o -iname '*.cxx'  \) -a \
       -exec egrep -q "$2" {} \; \
       -exec sed -r -i.bak "s/$2/$3/" {} \; -print
}


alias flash_vids="file /proc/\$(ps aux | grep conta | grep flash  | tr -s ' ' | cut -d ' ' -f 2)/fd/*  | grep deleted | cut -d ':' -f 1"
alias flash_kill="kill \$(ps aux | grep conta | grep flash | tr -s ' ' | cut -d ' ' -f '2')"


function teamcity_wget {
    TEAMCITY_URL=$1

    wget --http-user=tomek --ask-password $(echo ${TEAMCITY_URL}| sed -r 's/(http:\/\/[a-zA-Z0-9]+)(\/.*)/\1\/httpAuth\2/')
}
