#=============================================================================#
#                                                                             #
#                         QueezyTheGreat's ZSHRC file                         #
#                                                                             #
#=============================================================================#


if which jenv > /dev/null; then eval "$(jenv init -)"; fi



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
    setopt auto_cd
    setopt histignorespace

    fpath=(~/.zsh/functions/VCS_Info
           ~/.zsh/functions/VCS_Info/Backends
           ~/.zsh/functions
           /usr/local/share/zsh-completions
           $fpath)

    cdpath=(~/
            ~/storage/)



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
    TEMPATH="/usr/local/bin:$HOME/bin:/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/sbin:/usr/X11R6/bin:/usr/games:."
    echo ${PATH} | grep -q "${TEMPATH}" || export PATH="$TEMPATH:$PATH"
    export PATH="${HOME}/.scripts:${PATH}"

    if [ -d "/usr/local/Cellar" ]; then
        CPATH="${CPATH}"
        for include_path in /usr/local/Cellar/*/*/include; do
            CPATH="${include_path}:${CPATH}"
        done

        LIBRARY_PATH="${LIBRARY_PATH}"
        for library_path in /usr/local/Cellar/*/*/lib; do
            LIBRARY_PATH="${library_path}:${LIBRARY_PATH}"
        done
    fi

    # Disable virtualenv prompt modification
    #
    export VIRTUAL_ENV_DISABLE_PROMPT="x"
    [ ! -z "${VIRTUAL_ENV}" ] && export BUILD_ENVIRONMENT="VIRTENV"

    export LANG=en_US.UTF-8
    export LC_ALL=en_US.UTF-8
    export LC_COLLATE="C"
    unsetopt ALL_EXPORT



#=============================================================================#
#                                   Aliases                                   #
#=============================================================================#
    alias slrn="slrn -n"
    alias f=finger
    alias ll='ls -al'
    alias ls='ls --color=auto '
    alias rest2html-css='rest2html --embed-stylesheet --stylesheet-path=/usr/share/python-docutils/stylesheets/default.css'
    alias apt-get='sudo apt-get'
    alias apt-install='apt-get install'
    alias apt-search='apt-cache search'
    alias apt-info='apt-cache show'

    alias c=clear
    alias cl=clear
    alias cls=clear
    alias =clear

    alias tmux="tmux -2"
    if type dircolors &> /dev/null; then
        eval `dircolors`
    fi

    if type ack-grep &> /dev/null; then
        alias ack='ack-grep'
    fi


    if [ "$(uname)" = "Darwin" ]; then
        alias ls='ls -G'
        alias vlc="/Applications/VLC.app/Contents/MacOS/VLC"
    else
        alias ls='ls --color=auto '
    fi

    IGNORE_COLOR='c235'
    FILE_COLOR='c237'
    ERROR_COLOR='c196'
    WARN_COLOR='c220'
    SOURCE_COLOR='c244'
    INFO_COLOR='c34'
    DEBUG_COLOR='c252'

    alias k="kubectl"

    alias dd="docker-develop"

    if type bat &> /dev/null; then
        alias cat='bat'       # Replace with better cat
    fi
    if type lsd &> /dev/null; then
        alias ls='lsd'        # Replace with better ls
    fi

    alias yabai-windows="yabai -m query --windows | jq '.[] | .app + \": \" + .title'"
    alias lg='lazygit'

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
        for keycode in '[' 'O'; do
          bindkey "^[${keycode}A" history-substring-search-up
          bindkey "^[${keycode}B" history-substring-search-down
        done
        unset keycode
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
        local JOB_COUNT="$(jobs | wc -l)"
        local PROMPT_TITLE_PREFIX=""
        [ "${JOB_COUNT}" -lt 1 ] && PROMPT_TITLE_PREFIX="● "
        if [ -z "${SHORT_PROMPT_TITLE}" ]; then
            print -Pn "\e]0;${PROMPT_TITLE_PREFIX}%~\a"
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
    source ~/.zsh/scripts/chroot_environments.sh

    alias u1004='chroot /srv/chroot/ubuntu-10.04 /bin/bash -c "cd;export BUILD_ENVIRONMENT=ubuntu-10.04;${SHELL}"'
    alias u1104='chroot /srv/chroot/ubuntu-11.04 /bin/bash -c "cd;export BUILD_ENVIRONMENT=ubuntu-11.04;${SHELL}"'
    alias u1204='chroot /srv/chroot/ubuntu-12.04 /bin/bash -c "cd;export BUILD_ENVIRONMENT=ubuntu-12.04;${SHELL}"'
    alias c64='chroot /srv/chroot/centos-6.4 /bin/bash -c "cd;export BUILD_ENVIRONMENT=centos-6.4;${SHELL}"'

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

#=============================================================================#
#                               MiniKube                                      #
#=============================================================================#
if [ $commands[minikube] ]; then
  source <(minikube completion zsh)
fi
if [ $commands[kubectl] ]; then
  source <(kubectl completion zsh)
fi
if [ $commands[kompose] ]; then
    source <(kompose completion zsh)
fi
#=============================================================================#
#                               Local Settings                                #
#=============================================================================#
ZSHRC_LOCAL="${HOME}/.zshrc_local"

if [ -f "${ZSHRC_LOCAL}" ]; then
    source ${ZSHRC_LOCAL}
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
