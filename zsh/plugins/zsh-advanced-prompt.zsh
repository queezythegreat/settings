autoload -Uz vcs_info
autoload -U add-zsh-hook
autoload colors zsh/terminfo

#===============================#
#     VCS Info Settings         #
#===============================#
    zstyle ':vcs_info:*' enable svn git hg
    zstyle ':vcs_info:*' stagedstr   '●'
    zstyle ':vcs_info:*' unstagedstr '●'
    zstyle ':vcs_info:*' check-for-changes true
    zstyle ':vcs_info:*' get-revision false  # May be very slow
    zstyle ':vcs_info:*' formats "%s[%b] -- "
    zstyle ':vcs_info:*' actionformats '%s[%b] -- '
    zstyle ':vcs_info:(sv[nk]|bzr):*' branchformat '%r'
    zstyle ':vcs_info:hg:*' branchformat '%b'
    zstyle ':vcs_info:*+set-message:*' hooks vcsinfo
    zstyle ':vcs_info:*+no-vcs:*'      hooks vcsinfo

function +vi-vcsinfo() {
    hook_com[vcs]=${hook_com[vcs]/#%git-svn/git}
    for KEY in action branch base base-name subdir staged unstaged revision misc vcs; do
        KEY_NAME="${KEY/-/_}"
        KEY_NAME="${KEY_NAME:u}"
        export "VCS_${KEY_NAME}=${hook_com[$KEY]}"
    done
}

function advanced_prompt_setup() {
    setopt prompt_subst
    setopt promptpercent

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
    L_BRACKET='${LINE_COLOR}${PR_SHIFT_IN}u${PR_SHIFT_OUT}'
    R_BRACKET='${LINE_COLOR}${PR_SHIFT_IN}t${PR_SHIFT_OUT}'
    V_BAR='${LINE_COLOR}${PR_SHIFT_IN}x${PR_SHIFT_OUT}'
    SEPERATOR='${LINE_COLOR}${PR_SHIFT_IN}${PR_HBAR}${PR_HBAR}${PR_SHIFT_OUT}'


    USER_HOST='${USER_COLOR}%(!.%SROOT%s.%n)${HOST_COLOR}@%m'
    CURRENT_WD='${CWD_COLOR}%${PR_PWDLEN}<...<%~%<<'
    #CURRENT_TIME='${(e)PR_APM}$PR_YELLOW%D{%H:%M}$PR_LIGHT_BLUE:%(!.$PR_RED.$PR_WHITE)%#'

    CURRENT_TIME='${(e)PR_APM}$PR_YELLOW%D{%H:%M}$PR_LIGHT_BLUE'
    CURRENT_DATE='${PR_YELLOW}%D{%a,%b%d}${PR_BLUE}'
    CURRENT_JOBS='${PR_GREEN}$(job_name)${PR_RED}$(job_count)'

    EXIT_CODE='%(?..${LINE_COLOR}[${EXIT_CODE_COLOR}%?${LINE_COLOR}] )'

    CMD_CONTINUATION='${PR_LIGHT_GREEN}%_'

    #SET_TITLEBAR='${PR_SET_CHARSET}${PR_STITLE}${(e)PR_TITLEBAR}'
    SET_TITLEBAR=''
    SPACER='${LINE_COLOR}${PR_SHIFT_IN}${PR_HBAR}${PR_SHIFT_OUT}'

    CHROOT=""
    [[ ! -z "${BUILD_ENVIRONMENT}" ]] && CHROOT="[${BUILD_ENVIRONMENT}] "
    [[ ! -z "${CHROOT}" ]] && CHROOT_PRMPT="${PR_RED}${CHROOT}"

    VCS_TYPE='${VCS_VCS:+'${SEPERATOR}' ${PR_RED}${VCS_VCS:u}${PR_YELLOW}${VCS_BRANCH:+[}${VCS_BRANCH}${VCS_BRANCH:+]}}${VCS_VCS:+ }'
    VCS_STAGE='${PR_RED}${VCS_UNSTAGED:-'${SPACER}'}${PR_GREEN}${VCS_STAGED:-'${SPACER}'}'
    VCS_ACTIONS='${VCS_ACTION:+${LINE_COLOR}'${BL_CORNER}${SPACER}'%\[${PR_RED}${VCS_ACTION:u}${LINE_COLOR}%\]'${SPACER}}


    PROMPT="${SET_TITLEBAR}$TL_CORNER ${USER_HOST} ${SEPERATOR} ${CHROOT_PRMPT}$CURRENT_WD ${VCS_TYPE}${FILLER}${TR_CORNER}
"
    PROMPT+="${BL_CORNER}${VCS_STAGE}${PR_NO_COLOUR} "

    RPROMPT="${EXIT_CODE}${VCS_ACTIONS}$BL_CORNER${SPACER}${L_BRACKET}${CURRENT_JOBS}${CURRENT_DATE} ${CURRENT_TIME}${R_BRACKET}${BR_CORNER}${PR_NO_COLOUR}"

    PS2="${BL_CORNER}${SEPERATOR} ${CMD_CONTINUATION}${PR_BLUE} ${SEPERATOR}${PR_NO_COLOUR} "
}

function advanced_prompt_precmd() {
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
    set -A altchar "${(s..)terminfo[acsc]}"
    PR_SET_CHARSET="%{$terminfo[enacs]%}"
    PR_SHIFT_IN="%{$terminfo[smacs]%}"
    PR_SHIFT_OUT="%{$terminfo[rmacs]%}"
    PR_HBAR="q"
    PR_ULCORNER="l"
    PR_LLCORNER="m"
    PR_LRCORNER="j"
    PR_URCORNER="k"
}

#add-zsh-hook chpwd chpwd_update_git_vars
#add-zsh-hook preexec preexec_update_git_vars
add-zsh-hook precmd advanced_prompt_precmd

advanced_prompt_setup  # Setup prompt
