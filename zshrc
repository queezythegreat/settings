# =========================== #
# QueezyTheGreat's ZSHRC file #
# =========================== #
bindkey -e

fpath=(~/.zsh/functions/VCS_Info $fpath)

#===============================#
#     ZSH FeaturesVariables     #
#===============================#
    #setopt NOTIFY
    #setopt NO_FLOW_CONTROL
    setopt APPEND_HISTORY
    setopt NO_AUTO_MENU
    # setopt AUTO_LIST         # these two should be turned off
    # setopt AUTO_REMOVE_SLASH
    # setopt AUTO_RESUME       # tries to resume command of same name
    unsetopt BG_NICE           # do NOT nice bg commands
    setopt CORRECT             # command CORRECTION
    setopt EXTENDED_HISTORY    # puts timestamps in the history
    setopt HASH_CMDS           # turns on hashing
    setopt extended_glob


#===============================#
#     Environment Variables     #
#===============================#
    setopt ALL_EXPORT
    HISTFILE=$HOME/.zhistory
    HISTSIZE=10000
    SAVEHIST=10000

    TZ="Europe/Warsaw"

    HOSTNAME="$(hostname)"
    PAGER="less"
    EDITOR="vim"

    PYTHON_PATH="python-libs:$PYTHON_PATH"
    CPATH="$HOME/bin:/usr/local/bin:/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/sbin:/usr/X11R6/bin:/usr/games:."
    echo ${PATH} | grep -q "${CPATH}" || export PATH="$CPATH:$PATH"


    LANG=en_US.utf8
    LC_ALL=
    LC_COLLATE="C"
    unsetopt ALL_EXPORT

#===============================#
#     Plugins                   #
#===============================#
    source ~/.zsh/plugins/zsh-history-substring-search.plugin.zsh
    source ~/.zsh/plugins/zsh-history-substring-search.zsh

#===============================#
#     Aliases                   #
#===============================#
    alias slrn="slrn -n"
    alias f=finger
    alias ll='ls -al'
    alias ls='ls --color=auto '
    alias rest2html-css='rest2html --embed-stylesheet --stylesheet-path=/usr/share/python-docutils/stylesheets/default.css'

    alias c=clear
    alias cl=clear
    alias cls=clear
    alias =clear

    alias tmux="tmux -2"
    if type dircolors &> /dev/null; then
        eval `dircolors`
    fi

#===============================#
#     Completion                #
#===============================#
    zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
    zstyle ':completion:*' matcher-list 'm:{[:lower:]}={[:upper:]}'
    zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

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
autoload -U vcs_info
autoload colors zsh/terminfo
compinit

#===============================#
#     VCS Info                  #
#===============================#
    zstyle ':vcs_info:*' enable svn git hg
    zstyle ':vcs_info:*' stagedstr   '●'
    zstyle ':vcs_info:*' unstagedstr '●'
    zstyle ':vcs_info:*' check-for-changes true
    zstyle ':vcs_info:(sv[nk]|bzr):*' branchformat '%r'
    zstyle ':vcs_info:(svn|hg|hg-git)*' formats '%s[%b] -- '
    zstyle ':vcs_info:git*' formats "%s[%b] -- "
    zstyle ':vcs_info:*+set-message:*' hooks vcsinfo
    zstyle ':vcs_info:*+no-vcs:*' hooks vcsinfo

function +vi-vcsinfo() {
    hook_com[vcs]=${hook_com[vcs]/#%git-svn/git}
    for KEY in action branch base base-name subdir staged unstaged revision misc vcs; do
        KEY_NAME="${KEY/-/_}"
        KEY_NAME="${KEY_NAME:u}"
        export "VCS_${KEY_NAME}=${hook_com[$KEY]}"
    done
}


function precmd {
    vcs_info

    local TERMWIDTH
    (( TERMWIDTH = ${COLUMNS} - 1 ))


    ###
    # Truncate the path if it's too long.
    
    PR_FILLBAR=""
    PR_PWDLEN=""
    
    local promptsize=${#${(%):---(%n@%m)---()--}}
    local pwdsize=${#${(%):-%~}}
    local chrootsize=${#CHROOT}
    local vcs_info_size=$((${#vcs_info_msg_0_}))
    
    if [[ "$promptsize + $pwdsize" -gt $TERMWIDTH ]]; then
        ((PR_PWDLEN=$TERMWIDTH - $promptsize))
    else
        PR_FILLBAR="\${(l.(($TERMWIDTH - (1 + $promptsize + $pwdsize + $chrootsize + $vcs_info_size )))..${PR_HBAR}.)}"
    fi
}


function preexec () {
    if [[ "$TERM" == "screen" ]]; then
    local CMD=${1[(wr)^(*=*|sudo|-*)]}
    echo -n "\ek$CMD\e\\"
    fi
}

function setup_colors {
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
}

function setup_prompt() {
    setopt prompt_subst

    setup_colors

    
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

    TL_CORNER='${LINE_COLOR}${PR_SHIFT_IN}${PR_ULCORNER}${PR_HBAR}${PR_HBAR}${PR_SHIFT_OUT}'
    TR_CORNER='${LINE_COLOR}${PR_SHIFT_IN}${PR_HBAR}${PR_URCORNER}${PR_SHIFT_OUT}'
    BL_CORNER='${LINE_COLOR}${PR_SHIFT_IN}${PR_LLCORNER}${PR_SHIFT_OUT}'
    BR_CORNER='${LINE_COLOR}${PR_SHIFT_IN}${PR_HBAR}${PR_LRCORNER}${PR_SHIFT_OUT}'
    FILLER='${LINE_COLOR}${PR_SHIFT_IN}${(e)PR_FILLBAR}${PR_HBAR}${PR_SHIFT_OUT}'

    USER_HOST='${USER_COLOR}%(!.%SROOT%s.%n)${HOST_COLOR}@%m'
    CURRENT_WD='${CWD_COLOR}%${PR_PWDLEN}<...<%~%<<'
    #CURRENT_TIME='${(e)PR_APM}$PR_YELLOW%D{%H:%M}$PR_LIGHT_BLUE:%(!.$PR_RED.$PR_WHITE)%#'

    CURRENT_TIME='${(e)PR_APM}$PR_YELLOW%D{%H:%M}$PR_LIGHT_BLUE'
    CURRENT_DATE='${PR_YELLOW}%D{%a,%b%d}${PR_BLUE}'
    CURRENT_JOBS='${PR_GREEN}$(job_name)${PR_RED}$(job_count)'

    EXIT_CODE='%(?..${LINE_COLOR}[${EXIT_CODE_COLOR}%?${LINE_COLOR}] )'

    SEPERATOR='${LINE_COLOR}${PR_SHIFT_IN}${PR_HBAR}${PR_HBAR}${PR_SHIFT_OUT}'
    CMD_CONTINUATION='$PR_LIGHT_GREEN%_'

    SET_TITLEBAR='$PR_SET_CHARSET$PR_STITLE${(e)PR_TITLEBAR}'
    SPACER='${LINE_COLOR}${PR_SHIFT_IN}${PR_HBAR}${PR_SHIFT_OUT}'

    CHROOT=""
    [[ ! -z "${BUILD_ENVIRONMENT}" ]] && CHROOT="[${BUILD_ENVIRONMENT}] "
    [[ ! -z "${CHROOT}" ]] && CHROOT_PRMPT="${PR_RED}${CHROOT}"

    VCS_TYPE='${PR_RED}${VCS_VCS:+${VCS_VCS:u}${PR_YELLOW}${VCS_BRANCH:+[}${VCS_BRANCH}${VCS_BRANCH:+]} '${SEPERATOR}'}${VCS_VCS:+ }'
    VCS_STAGE='${PR_RED}${VCS_UNSTAGED:-'${SPACER}'}${PR_GREEN}${VCS_STAGED:-'${SPACER}'}'


    PROMPT="${SET_TITLEBAR}$TL_CORNER ${USER_HOST} ${SEPERATOR} ${CHROOT_PRMPT}${VCS_TYPE}$CURRENT_WD ${FILLER}${TR_CORNER}
"
    PROMPT+="${BL_CORNER}${VCS_STAGE}${PR_NO_COLOUR} "

    RPROMPT="${EXIT_CODE}$BL_CORNER%\[${CURRENT_JOBS}${CURRENT_DATE} ${CURRENT_TIME}\${LINE_COLOR}%\]${BR_CORNER}${PR_NO_COLOUR}"

    PS2="${SEPERATOR}(${CMD_CONTINUATION}${PR_BLUE})${SEPERATOR}${PR_NO_COLOUR} "
}

function job_name() {
    JOB_NAME=""
    JOB_LENGTH=0
    if [ "${COLUMNS}" -gt 69 ]; then
        JOB_LENGTH=$((${COLUMNS}-70))
        [ "${JOB_LENGTH}" -lt "0" ] && JOB_LENGTH=0
    fi

    if [ "${JOB_LENGTH}" -gt 0 ]; then
        JOB_NAME=$(jobs|grep +|tr -s " "|cut -d " " -f 4-|cut -b 1-${JOB_LENGTH}|sed "s/\(.*\)/\1:/")
    fi

    echo "${JOB_NAME}"
}

function job_count() {
    local JOB_COUNT
    JOB_COUNT=$(jobs | wc -l)
    if [ "${JOB_COUNT}" -gt 0 ]; then
        echo "${JOB_COUNT}${PR_LIGHT_BLUE}|"
    fi
}

setup_prompt

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


alias u1004='chroot /srv/chroot/ubuntu-10.04 /bin/bash -c "cd;export BUILD_ENVIRONMENT=ubuntu-10.04;${SHELL}"'
alias u1104='chroot /srv/chroot/ubuntu-11.04 /bin/bash -c "cd;export BUILD_ENVIRONMENT=ubuntu-11.04;${SHELL}"'

if [ ! -x "${BUILD_ENVIRONMENT}" -a -f "${BUILD_ENVIRONMENT}.sh" ]; then
    . "${BUILD_ENVIRONMENT}.sh"
fi

function quickfix {
    ${*} 2>&1 | tee .quickfix
    vim --servername VIM --remote-expr "LoadQuickfix(\"$(pwd)/.quickfix\")"
}

if vim --version | grep -q '\+X11'; then
    alias vim='vim --servername VIM -p'
else
    alias vim='vim -p'
fi
