" File: plugin/ProjectTag.vim
" Version: 0.1.10
" GetLatestVimScripts: 3219 1 :AutoInstall: ProjectTag.zip
" check doc/ProjectTag.txt for more version information

if v:version < 700
    finish
endif

if !has('python')
    command GenProTags 
                \echohl ErrorMsg | 
                \echo 'ProjectTag: Python is not enabled in your vim.'.
                \' This plugin would not be enabled.' | echohl None
    command GenProTagsBg
                \echohl ErrorMsg | 
                \echo 'ProjectTag Python is not enabled in your vim.'.
                \' This plugin would not be enabled.' | echohl None
    finish
endif

" check whether this script is already loaded
if exists("g:loaded_ProjectTag")
    finish
endif
let g:loaded_ProjectTag = 1

let s:saved_cpo = &cpo
set cpo&vim

" initialization {{{1
let s:py_dir = substitute(findfile('plugin/ProjectTag/ProjectTag.py', &rtp),
            \'/ProjectTag.py', '', '')

let s:default_project_name = 'project.prom'

" this variables is used as a flag showing whether to finish the script, since
" in python code, vim.command('finish') is not allowed
let s:does_finish_flag = 0 

python << EEOOFF

try:
    # import required libraries
    import vim
    import threading
    import sys
    import os

    # add $VIMRUNTIME/ProjectTag to module search directory
    sys.path.append( os.path.abspath( vim.eval('s:py_dir')) )

    import ProjectTag

    # the default project name
    ProjectTag.default_project_name = vim.eval( 's:default_project_name' )

    # add the tag file
    pc = ProjectTag.ProjectConfig( vim.eval('s:default_project_name') )
    pc.add_tag_file()
    del pc

# if required python packages are not found, then don't generate tags.
except ImportError:
    vim.command(
    'command GenProTags echohl ErrorMsg | echo '
    '"ProjectTag: Some python packages required by ProjectTag are missing '
    'on your system. Install these missing packages and restart vim to'
    ' enable this plugin." | echohl None' )

    vim.command( 
    'command GenProTagsBg echohl ErrorMsg | echo '
    '"ProjectTag: Some python packages required by ProjectTag are missing '
    'on your system. Install these missing packages and restart vim to'
    ' enable this plugin." | echohl None' )

    # if need to finish, set s:does_finish to 1
    vim.command('let s:does_finish_flag = 1')

EEOOFF

" if the python code above calls for a finish, then finish
if s:does_finish_flag
    finish
endif

" autocmd {{{1
" automatically add the tags file when entering a buffer
autocmd BufEnter * python ProjectTag.ProjectConfig(
            \vim.eval('s:default_project_name') ).add_tag_file()
" regard project.prom as ini files
autocmd BufEnter project.prom setlocal ft=dosini

" functions {{{1

" generate tags
function s:GenerateProjectTags( back_ground )

    exec 'py ProjectTag.generate_pro_tags( '.a:back_ground.' )'

endfunction


" commands {{{1
command GenProTags call s:GenerateProjectTags(0)
command GenProTagsBg call s:GenerateProjectTags(1)

" }}}


let &cpo = s:saved_cpo
unlet! s:saved_cpo

" vim: fdm=marker et ts=4 sw=4 tw=78
