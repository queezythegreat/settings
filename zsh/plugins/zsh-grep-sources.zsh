
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

function find_file {
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
function grep_files {
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
function grep_headers {
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
function grep_sources {
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
function grep_cmakes {
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
