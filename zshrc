#=============================================================================#
#                                                                             #
#                         QueezyTheGreat's ZSHRC file                         #
#                                                                             #
#=============================================================================#





#=============================================================================#
#                           ZSH Features                                      #
#=============================================================================#
    bindkey -e
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

    fpath=(~/.zsh/functions/VCS_Info
           ~/.zsh/functions/VCS_Info/Backends
           ~/.zsh/functions
           $fpath)



#=============================================================================#
#                           Environment Variables                             #
#=============================================================================#
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
    export PATH="${HOME}/.scripts:${PATH}"


    LANG=en_US.utf8
    LC_ALL=
    LC_COLLATE="C"
    unsetopt ALL_EXPORT



#=============================================================================#
#                                   Aliases                                   #
#=============================================================================#
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


    if [ "$(uname)" = "Darwin" ]; then
        alias ls='ls -G'
        alias vlc="/Applications/VLC.app/Contents/MacOS/VLC"
    else
        alias ls='ls --color=auto '
    fi


#=============================================================================#
#                                  Completion                                 #
#=============================================================================#
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



#=============================================================================#
#                                Plugins                                      #
#=============================================================================#
    source ~/.zsh/plugins/zsh-history-substring-search.plugin.zsh
    if [ -z "${NO_ADVANCED_PROMPT}" ]; then
        source ~/.zsh/plugins/zsh-advanced-prompt.zsh
    else
        autoload -U promptinit
        promptinit
        prompt redhat
    fi
    source ~/.zsh/plugins/zsh-grep-sources.zsh

    autoload -U compinit
    compinit


#=============================================================================#
#                               Prompt Setup                                  #
#=============================================================================#
    # Executed befor executing command
    function preexec () {
        if [[ "$TERM" == "screen" ]]; then
            local CMD=${1[(wr)^(*=*|sudo|-*)]}
            echo -n "\ek$CMD\e\\"
        else
            print -Pn "\e]0;${1}\a"
        fi
    }

    # Executed before drawing of prompt
    function precmd () {
        setopt prompt_subst
        setopt promptpercent
        if [ -z "${SHORT_PROMPT_TITLE}" ]; then
            print -Pn "\e]0;ZSH %n@%m %~\a"
        else
            print -Pn "\e]0;ZSH %~\a"
        fi
    }



#=============================================================================#
#                                  Functions                                  #
#=============================================================================#
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


#=============================================================================#
#                                  Flash                                      #
#=============================================================================#
    alias flash_vids="file /proc/\$(ps aux | grep conta | grep flash  | tr -s ' ' | cut -d ' ' -f 2)/fd/*  | grep deleted | cut -d ':' -f 1"
    alias flash_kill="kill \$(ps aux | grep conta | grep flash | tr -s ' ' | cut -d ' ' -f '2')"


function teamcity_wget {
    TEAMCITY_URL=$1

    wget --http-user=tomek --ask-password $(echo ${TEAMCITY_URL}| sed -r 's/(http:\/\/[a-zA-Z0-9]+)(\/.*)/\1\/httpAuth\2/')
}


#=============================================================================#
#                                  chroots                                    #
#=============================================================================#
    alias u1004='chroot /srv/chroot/ubuntu-10.04 /bin/bash -c "cd;export BUILD_ENVIRONMENT=ubuntu-10.04;${SHELL}"'
    alias u1104='chroot /srv/chroot/ubuntu-11.04 /bin/bash -c "cd;export BUILD_ENVIRONMENT=ubuntu-11.04;${SHELL}"'

    if [ ! -x "${BUILD_ENVIRONMENT}" -a -f "${BUILD_ENVIRONMENT}.sh" ]; then
        . "${BUILD_ENVIRONMENT}.sh"
    fi


#=============================================================================#
#                                    VIM                                      #
#=============================================================================#
if [ -z "${WINDIR}" ]; then
    if vim --version | grep -q '\+X11'; then
        alias vim='vim --servername VIM -p'
    else
        alias vim='vim -p'
    fi

    function quickfix {
        ${*} 2>&1 | tee .quickfix
        if [ -z "${VIM_SERVER_NAME}" ] && local VIM_SERVER_NAME="VIM"
        vim --servername "${VIM_SERVER_NAME}" --remote-expr "LoadQuickfix(\"$(pwd)/.quickfix\")"
    }
fi


function infinity {
    while true; do
        $*
    done
}

alias date_formated='date +%m%d%H%M%Y.%S'

alias qtest_color="colorize green 'PASS.*' white@bold '^\*\*\*.*' white '^Totals:' white '^Config:.*' red '[0-9]\+ failed' green '[0-9]\+ passed' yellow '[0-9]\+ skipped' c236 '^QDEBUG :.*' c240 '=\+ ENTER.*' c240 '=\+ EXIT.*' c236 '.*' except '^[^:]\+:.*' red 'FAIL!  : .*' red '   Loc: .*'"

