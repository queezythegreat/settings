" =========================== "
" QueezyTheGreat's VIMRC file "
" =========================== "
    set nocompatible  " Disable vi compatibility mode
    set laststatus=2  " Staus bar always visible
    set backspace=2   " Enable backspace do delete previous characters 
    set shortmess=Imnrwx
    set noswf
    "set guifont=Lucida\ Console\ Semi-Condensed\ 12
    set guioptions=
    set sessionoptions=blank,buffers,curdir,folds,globals,localoptions,options,resize,tabpages,winsize,winpos
    set clipboard=unnamed,autoselect   " Yank/Paste globally
    set encoding=utf-8  " The encoding displayed.
    set fileencoding=utf-8  " The encoding written to file.
    set mouse=nicr


" ------------------- "
"     Tab Options     "
" ------------------- "
    set autoindent     " Enables auto indenting
    set smartindent    " Enable Smart Indenting
    set tabstop=4      " Tab character equals 4 spaces
    set expandtab      " Expands Tab's to spaces
    set shiftwidth=4   " Indentation width for autoindent
    set softtabstop=4  " Treat multiple spaces as a tab
    filetype indent on " Enable indentation based on file type
    set switchbuf+=usetab,newtab  " User existing tab if exist, otherwise new tab

" ---------------------- "
"     Search Options     "
" ---------------------- "
    set incsearch     " Incremental search
    set ignorecase    " Ignore case in searches
    set smartcase     " Disables ignorecase if uppercase characters appear in search term
    set nohls         " Disables highlighting search results...
    noremap <leader>h :let &hls=!&hls<cr>

" ----------------------------- "
"     Diplay/Color  Options     "
" ----------------------------- "
    set t_Co=256                            " Sets display to 256 colors.
    colorscheme desert256                   " Loads Desert256 color scheme
    syntax enable                           " Enables syntax highlighting

    set showmatch                           " Briefly highlights matching brace/paranthese/bracket's
    set vb t_vb=                            " Enables visual bell, no beeping sound
    set noerrorbells                        " Disables beeps
    set ruler                               " Displays cursor position in status line
    set number                              " Displays line numbers
    set numberwidth=5                       " Number gutter width

    set scrolloff=5                         " 3 lines of offset when scrolling
    set showcmd                             " Show parcial commands in the status line
    set showmode                            " Show current mode which VIM is in

    set wildmode=longest:full,list          " Tab completion command mode
    set complete=.,w,b,u,t
    set completeopt=longest,menuone         " Tab completion insert mode
    set infercase

    set nostartofline                       " Don't jump to begining of the line

    set iskeyword=@,48-57,_,192-255,-,@-@

    set whichwrap=<,>,h,l,b                 " Allow navigation with line wrapping

    " Alwasy show sign's gutter
    autocmd BufEnter * sign define dummy
    autocmd BufEnter * execute 'sign place 9999 line=1 name=dummy buffer=' . bufnr('')

" ------------------------------ "
"     Indent Folding Options     "
" ------------------------------ "
    set foldenable        " Enables folding
    set foldmethod=indent " Sets the folding method
    set foldlevelstart=99 " Disable automatic folding on start

    set bufhidden=hide    " Hide buffer when not in window

    " Automatically fold on file open!
    autocmd! BufRead * normal zM

" ------------------------------ "
"     File Type Dectection       "
" ------------------------------ "
    filetype on           " Enable file type detection
    filetype plugin on    " Loads plugins associated with file type 

    au BufRead,BufNewFile *.pde set filetype=cpp
    au BufRead,BufNewFile *.ino set filetype=cpp


" ------------------------------ "
"     Backup Files               "
" ------------------------------ "
    set nobackup          " Disable bakups of files
    set nowritebackup     " Disable writing backup files

" ------------------------------ "
"     Keyboard Mappings          "
" ------------------------------ "
    cabbr Q qa
    cabbr tlt TlistToggle
    imap <C-C> <Esc>vb~wa
    noremap <space> za
    
    "map <silent> <F2> <ESC>:make!<CR>
    map <C-\> :vert belowright split<CR> :exec("tselect ".expand("<cword>"))<CR>
    " Open file under cursor in new tab
    map <leader>g <c-w>gf
    " Open file under cursor in new tab
    map <leader>G gf

" ------------------------------ "
"     Window Navigation       "
" ------------------------------ "
    " Window navigation shortcuts
    map <C-H> <C-W>h
    map <C-J> <C-W>j
    map <C-K> <C-W>k
    map <C-L> <C-W>l

    " Enable changing windows within insert mode
    imap <C-H> <ESC><C-W>h
    imap <C-J> <ESC><C-W>j
    imap <C-K> <ESC><C-W>k
    imap <C-L> <ESC><C-W>l

    " Close window
    map <C-C> <C-W>c


" ------------------------------ "
"     Tab Settings               "
" ------------------------------ "
    if exists("+tabline")
        " Tab navigation
        map <C-N> :tabnext<CR>
        map <C-P> :tabprev<CR>

        map <leader>1  :tabnext  1<CR>
        map <leader>2  :tabnext  2<CR>
        map <leader>3  :tabnext  3<CR>
        map <leader>4  :tabnext  4<CR>
        map <leader>5  :tabnext  5<CR>
        map <leader>6  :tabnext  6<CR>
        map <leader>7  :tabnext  7<CR>
        map <leader>8  :tabnext  8<CR>
        map <leader>9  :tabnext  9<CR>
        map <leader>10 :tabnext 10<CR>
        map <leader>11 :tabnext 11<CR>
        map <leader>12 :tabnext 12<CR>
        map <leader>13 :tabnext 13<CR>
        map <leader>14 :tabnext 14<CR>
        map <leader>15 :tabnext 15<CR>
        map <leader>16 :tabnext 16<CR>
        map <leader>17 :tabnext 17<CR>
        map <leader>18 :tabnext 18<CR>
        map <leader>19 :tabnext 19<CR>
        map <leader>20 :tabnext 20<CR>
        map <leader>21 :tabnext 21<CR>
        map <leader>22 :tabnext 22<CR>
        map <leader>23 :tabnext 23<CR>
        map <leader>24 :tabnext 24<CR>
        map <leader>25 :tabnext 25<CR>
        map <leader>26 :tabnext 26<CR>
        map <leader>27 :tabnext 27<CR>
        map <leader>28 :tabnext 28<CR>
        map <leader>29 :tabnext 29<CR>
        map <leader>30 :tabnext 30<CR>
        map <leader>31 :tabnext 31<CR>
        map <leader>32 :tabnext 32<CR>
        map <leader>33 :tabnext 33<CR>
        map <leader>34 :tabnext 34<CR>
        map <leader>35 :tabnext 35<CR>

        " Remember last active tab
        let g:lasttab = 1
        nmap <Leader><tab> :exe "tabnext ".g:lasttab<CR>
        au TabLeave * let g:lasttab = tabpagenr()

        " See colorscheme desert256 for colors

        " Command abbriviations
        cabbr t tabnew

        " Custom Tab display function
        set tabline=%!MyTabLine()
        " Always display the tab line
        set showtabline=2


        function! GetTabPrefix(tabNum)
            return a:tabNum . '  '
        endfunction

        function! GetTabModified(tabNum)
            let tab_buffers_modified = 0
            for tab_buffer_id in tabpagebuflist(a:tabNum)
                if getbufvar(tab_buffer_id, "&mod")
                    let tab_buffers_modified = 1
                    break
                endif
            endfor
            return tab_buffers_modified
        endfunction

        function! GetTabName(tabNum)
            " filename for current window in tab, without path
            let bufferTitle = getbufvar(tabpagebuflist(a:tabNum )[tabpagewinnr(a:tabNum ) - 1], 'title')
            if bufferTitle != ''
                return bufferTitle
            endif

            let bufferRaw = bufname(tabpagebuflist(a:tabNum )[tabpagewinnr(a:tabNum ) - 1])
            if filereadable(bufferRaw)
                let bufferName = fnamemodify(bufferRaw, ':t')
            else
                let bufferName = bufferRaw
            endif
            " if empty, display [No Name]
            if bufferName == ''
                let bufferName = '[No Name]'
            endif
            return bufferName
        endfunction

        " Do we have any quickfix errors or warnins?
        function! GetQuickfix()
            let has_error = 0
            let has_warning = 0

            " Look in quickfix list
            for qf_entry in getqflist()
                if qf_entry.valid
                    if qf_entry.type == 'e'
                        let has_error = 1
                    endif
                    if qf_entry.type == 'w'
                        let has_warning = 1
                    endif
                endif
            endfor

            " Look in location list
            let index = 0
            while index <= tabpagenr('$')
                for qf_entry in getloclist(tabpagewinnr(index))
                    if qf_entry.valid
                        if qf_entry.type == 'e'
                            let has_error = 1
                        endif
                        if qf_entry.type == 'w'
                            let has_warning = 1
                        endif
                    endif
                endfor
                let index += 1
            endwhile

            if has_error
                return 2
            endif
            if has_warning
                return 1
            endif
            return 0
        endfunction

        function! GetTabQuickfix(tabNum)
            let tab_buffers = tabpagebuflist(a:tabNum)
            let has_error = 0
            let has_warning = 0

            for qf_entry in getqflist()
                if index(tab_buffers, qf_entry.bufnr) >= 0
                    if qf_entry.type == 'e'
                        let has_error = 1
                    endif
                    if qf_entry.type == 'w'
                        let has_warning = 1
                    endif
                endif
            endfor

            " Look in location list
            for qf_entry in getloclist(tabpagewinnr(a:tabNum))
                if index(tab_buffers, qf_entry.bufnr) >= 0
                    if qf_entry.type == 'e'
                        let has_error = 1
                    endif
                    if qf_entry.type == 'w'
                        let has_warning = 1
                    endif
                endif
            endfor

            if has_error
                return 2
            endif
            if has_warning
                return 1
            endif
            return 0
        endfunction

        function! RawTabName(tabNum)
            let tabName  = ' '
            let tabName .= GetTabPrefix(a:tabNum)
            let tabName .= GetTabName(a:tabNum)
            let tabName .= ' |'

            return tabName
        endfunction

        function! GetTabPrefixHighlight(tabNum)
            let modified = GetTabModified(a:tabNum)
            let quickfix = GetTabQuickfix(a:tabNum)
            if a:tabNum == tabpagenr()
                " Highlight active tab number with User2
                if !quickfix
                    if modified
                        return '%#TabLineSelModified#'
                    else
                        return '%#TabLineSel#'
                    endif
                else
                    if quickfix == 2
                        return '%#TabLineSelError#'
                    else
                        return '%#TabLineSelWarning#'
                    endif
                endif
            else
                " Highlight inactive tab number with User1
                if !quickfix
                    if modified
                        return '%#TabLineModified#'
                    else
                        return '%#TabLine#'
                    endif
                else
                    if quickfix == 2
                        return '%#TabLineError#'
                    else
                        return '%#TabLineWarning#'
                    endif
                endif
            endif
        endfunction

        function! GetTabNameHighlight(tabNum)
            return GetTabPrefixHighlight(a:tabNum)
            if a:tabNum == tabpagenr()
                " Highlight active tab name with TabLineSel
                return '%#TabLineSel#'
            else
                " Highlight inactive tab name with TabLine
                return '%#TabLine#'
            endif
        endfunction

        function! ConstructTabName(tabNum)
            " Tab start marker
            let tabName = '%' . a:tabNum . 'T'

            let tabName .= GetTabPrefixHighlight(a:tabNum)
            let tabName .= ' ' . GetTabPrefix(a:tabNum)

            let tabName .= GetTabNameHighlight(a:tabNum)
            let tabName .= GetTabName(a:tabNum)

            " Tab end marker
            let tabName .= ' %#TabLine#|'
            return tabName
        endfunction

        function! MyTabLine()
            let tabLinePrefix = ''

            let quickfix = GetQuickfix()
            if quickfix
                if quickfix == 2
                    let tabLinePrefix .= '%#TabLineError#'
                else
                    let tabLinePrefix .= '%#TabLineWarning#'
                endif
            endif

            let tabLineCount = ' '. tabpagenr('$')
            while len(tabLineCount) < &numberwidth
                let tabLineCount .= '  '
            endwhile
            let tabLinePrefix .= tabLineCount
            
            let tabLine = tabLinePrefix
            let rawTabLine = tabLinePrefix

            let index = 1
            while index <= tabpagenr('$')
                let tabName = ConstructTabName(index)
                let rawTabName = RawTabName(index)

                if (len(rawTabName) + len(rawTabLine) + 1) > &columns
                    if index > tabpagenr()
                        break
                    else
                        let tabLine = tabLinePrefix
                        let rawTabLine = tabLinePrefix
                    endif
                endif
                let tabLine .= tabName
                let rawTabLine .= rawTabName

                let index += 1
            endwhile
            " highlight 'elastic' part in TabLineFill,
            " then X (close current tab) in TabLine
            let tabLine .= '%#TabLineFill#%=%#TabLine#%999XX'
            return tabLine
        endfunction
    endif


" ------------------------------ "
"     Status Line Settings       "
" ------------------------------ "
    let &statusline="   %f  %<%=| %{(&fenc==\"\"?&enc:&fenc).((exists(\"+bomb\")\ &&\ &bomb)?\" BOMB\":\"\")} %(|  %M  %)%(|  %R  %)%0*|  %{&ff}  %(|  %W  %)%(|  %Y  %)| %4l %3v    %3p%% "


" ------------------------------ "
"     QuickFix Window            "
" ------------------------------ "
    function! GetBufferList()
      redir =>buflist
      silent! ls
      redir END
      return buflist
    endfunction

    function! ToggleList(bufname, pfx)
      let buflist = GetBufferList()
      for bufnum in map(filter(split(buflist, '\n'), 'v:val =~ "'.a:bufname.'"'), 'str2nr(matchstr(v:val, "\\d\\+"))')
        if bufwinnr(bufnum) != -1
          exec(a:pfx.'close')
          return
        endif
      endfor
      if a:pfx == 'l' && len(getloclist(0)) == 0
          echohl ErrorMsg
          echo "Location List is Empty."
          return
      endif
      let winnr = winnr()
      exec(a:pfx.'open')
      if winnr() != winnr
        wincmd p
      endif
    endfunction

    nmap <silent> <leader>l :call ToggleList("Location List", 'l')<CR>
    nmap <silent> <leader>q :call ToggleList("Quickfix List", 'c')<CR>

    autocmd! FileType qf wincmd J " Automatically move quickfix to bottom of Tab


" ------------------------------ "
"     Session Saving             "
" ------------------------------ "
    "set sessionoptions=blank,buffers,curdir,folds,help,resize,tabpages,winsize
    set viewoptions=folds,cursor    " Save only folds and cursor position

    " Save/Restore buffer states
    "au BufWinLeave         * if &buftype != "nofile" | silent! mkview   | endif
    "au BufRead,BufWinEnter * if &buftype != "nofile" | silent! loadview | endif

    " Don't screw up folds when inserting text that might affect them, until
    " leaving insert mode. Foldmethod is local to the window.Protect against
    " screwing up folding when switching between windows.
    autocmd InsertEnter          * if !exists('w:last_fdm') | let w:last_fdm=&foldmethod | setlocal foldmethod=manual | endif
    autocmd InsertLeave,WinLeave * if  exists('w:last_fdm') | let &l:foldmethod=w:last_fdm | unlet w:last_fdm | endif 

" ------------------------------ "
"     Screen Title               "
" ------------------------------ "
    if &term == "screen"
        set t_ts=k
        set t_fs=\
    endif
    if &term == "screen" || &term == "xterm"
        set title
        autocmd BufEnter * let &titlestring = "VIM: " . expand("%:t")
    endif


" ------------------------------ "
"     Tab Organization           "
" ------------------------------ "
    function! TabMoveLeft()
        if tabpagenr()>1
            execute "tabmove ".$(tabpagenr()-2)
        endif
    endfunction

    function! TabMoveRight()
        execute "tabmove ".tabpagenr()
    endfunction


" ------------------------------ "
"     Python  Settings           "
" ------------------------------ "
    " Python completion function
    autocmd FileType python set omnifunc=pythoncomplete#Complete

    " See colorscheme desert256 for highlight settings


" ------------------------------ "
"     Build in Background        "
" ------------------------------ "
    let g:ConqueQuickfixOutput_showOutput = 0

    function! ConqueQuickfixOutput(output)
        if len(a:output) > 0
            if g:ConqueQuickfixOutput_showOutput
                echo a:output
            endif
            let g:ConqueMakeOutput .= substitute(a:output, '','', 'g')
            silent cgete g:ConqueMakeOutput

            " Send out make autocmd event
            doautoall QuickFixCmdPost make
        endif

        if len(getqflist()) > 0
            echo 'Compiler errors and warnings: 'len(getqflist())
        else
            echo 'Build successfull.'
        endif
        "echo 'Is active count: ' . g:ConqueCallbackCount
        "let g:ConqueCallbackCount += 1
    endfunction

    " Set/display current make command (makeprg)
    function! ConqueMakeCMD(...)
        if a:0 > 0 && a:1 != ''
            let cmd = a:1
            let cmd = substitute(cmd, ' ','\\ ', 'g') " Escape space
            let cmd = substitute(cmd, '"','\\"', 'g') " Escape quotes
            execute 'set makeprg='. cmd
        endif
        echo 'Make CMD: '. &makeprg
    endfunction

    " Execute make command as subprocess using Conque
    function! ConqueMake(...)
        let g:ConqueMakeOutput = ''
        cgete ''
        "let g:ConqueCallbackCount = 0
        if a:0 > 0
            if a:1 != ''
                let build_command = a:1
            else
                let build_command = &makeprg
            endif
        else
            let build_command = &makeprg
        endif

        call CursorPosition("save")
        let sp = conque_term#subprocess(build_command)
        call sp.set_callback('ConqueQuickfixOutput')
        call CursorPosition("restore")
        echo 'Executed: ' . build_command
    endfunction

    " Save cursor and screen position
    function! CursorPosition(action)
        if a:action == "save"
            let b:saveve = &virtualedit
            let b:savesiso = &sidescrolloff
            set virtualedit=all
            set sidescrolloff=0
            let b:curline = line(".")
            let b:curvcol = virtcol(".")
            let b:curwcol = wincol()
            normal! g0
            let b:algvcol = virtcol(".")
            normal! M
            let b:midline = line(".")
            execute "normal! ".b:curline."G".b:curvcol."|"
            let &virtualedit = b:saveve
            let &sidescrolloff = b:savesiso
        elseif a:action == "restore"
            normal gg0
            let b:saveve = &virtualedit
            let b:savesiso = &sidescrolloff
            set virtualedit=all
            set sidescrolloff=0
            execute "normal! ".b:midline."Gzz".b:curline."G0"
            let nw = wincol() - 1
            if b:curvcol != b:curwcol - nw
                execute "normal! ".b:algvcol."|zs"
                let s = wincol() - nw - 1
                if s != 0
                    execute "normal! ".s."zl"
                endif
            endif
            execute "normal! ".b:curvcol."|"
            let &virtualedit = b:saveve
            let &sidescrolloff = b:savesiso
            unlet b:saveve b:savesiso b:curline b:curvcol b:curwcol b:algvcol b:midline
        endif
        return ""
    endfunction

    function! LoadQuickfix(...)
        if a:0 > 0
            let build_output = a:1
        else
            let build_output = g:QuickfixFile
        endif
        silent execute 'cgetfile '. build_output
        silent doautoall QuickFixCmdPost make
    endfunction

    command! -nargs=? -complete=shellcmd MakeCMD call ConqueMakeCMD('<args>')  " Set a makeprg command
    command! -nargs=? -complete=shellcmd Make    call ConqueMake('<args>')     " ConqueMake command with completion

    command! -nargs=? -complete=file LoadQuickfix call LoadQuickfix('<args>')     " Load quickfix from file

    set makeprg=make\ -e\ TERM=\ -C\ build
    compiler! cmake_gcc  " Set default compiler

    let g:QuickfixFile = 'build_out' " Quifix Error file to load

    map <F2> <ESC>:<C-U>call ConqueMake()<CR>
    "map <F3> <ESC>:<C-U>call LoadQuickfix()<CR>

" ------------------------------ "
"     Background Terminal        "
" ------------------------------ "
    function! BuildTerminalCMD(...)
        " Convert to plugin
        if !exists("g:build_terminal_obj") || (g:build_terminal_obj.active == 0)
            let cmdargs = 'NO_ADVANCED_PROMPT=1 SHORT_PROMPT_TITLE=1 VIM_SERVER_NAME='. v:servername .' zsh'
            let g:build_terminal_obj = conque_term#open('bash -c "'. cmdargs.'"', ['tabnew'])
        endif

        if a:0 > 0 && a:1 != ''
            let cmd = a:1
            if exists("g:build_terminal_obj") && (g:build_terminal_obj.active == 1)
                "silent execute 'python ' . g:ConqueTerm_Var . '.write(''' . cmd . ''' + "\n")'
                let g:build_terminal_cmd = cmd
                silent call g:build_terminal_obj.write(g:build_terminal_cmd ."\n")
                if a:0 > 1 && a:2 == ''
                    silent call g:build_terminal_obj.focus()
                endif
            endif
        endif
    endfunction

    function! BuildTerminalLastCMD()
        if exists("g:build_terminal_cmd")
            silent call BuildTerminalCMD(g:build_terminal_cmd, 1)
        else
            silent call BuildTerminalCMD("", 1)
        endif
    endfunction

    command! -nargs=? BuildTerminal     call BuildTerminalCMD(<q-args>)
    command! -nargs=? BuildTerminalBg   call BuildTerminalCMD(<q-args>, 1)
    command! -nargs=0 BuildTerminalLast call BuildTerminalLastCMD()

    nnoremap <silent> <F5> <ESC>:call BuildTerminalLastCMD()<CR>

" ------------------------------ "
"     Custom Commands            "
" ------------------------------ "
    command! VimrcEdit tabnew ~/.vimrc
    command! VimrcLoad source ~/.vimrc
    map <F3> <ESC>:VimrcEdit<CR>
    map <F4> <ESC>:VimrcLoad<CR>

    fun! ReadMan()
        " Assign current word under cursor to a script variable:
        let s:man_word = expand('<cword>')
        " Open a new window:
        :exe ":wincmd n"
        " Read in the manpage for man_word (col -b is for formatting):
        :exe ":r!man -s 2,3,7,9 " . s:man_word . " | col -b"
        " Goto first line...
        :exe ":goto"
        " and delete it:
        :exe ":delete"
        " finally set file type to 'man':
        :exe ":setlocal nofoldenable"
        :exe ":set filetype=man"
        :exe ":setlocal buftype=nofile"
        :exe ":setlocal bufhidden=hide"
        :exe ":setlocal noswapfile"
    endfun
    " Map the K key to the ReadMan function:
    map K :call ReadMan()<CR>


    command! DiffOrig vert new | set bt=nofile | r ++edit # | 0d_
        \ | diffthis | wincmd p | diffthis

    command! QuickfixClear call setqflist([])

" ------------------------------ "
"     Online Documentation       "
" ------------------------------ "
    function! OnlineDoc()
        if &ft =~ "cpp"
            let s:urlTemplate = "\"https://www.google.com/search?q=%&btnI\""
        elseif &ft =~ "ruby"
            let s:urlTemplate = "http://www.ruby-doc.org/core/classes/%.html"
        elseif &ft =~ "perl"
            let s:urlTemplate = "http://perldoc.perl.org/functions/%.html"
        else
            let s:urlTemplate = "\"https://www.google.com/search?q=%&btnI\""
        endif
        "let s:browser = "firefox"
        let s:browser = "open"
        let s:wordUnderCursor = expand("<cword>")
        let s:url = substitute(s:urlTemplate, "%", s:wordUnderCursor, "g")
        let s:cmd = "silent !" . s:browser . " " . s:url
        execute s:cmd
        redraw!
    endfunction

    " Online doc search.
    map Q :call OnlineDoc()<CR>
    map <leader>c <ESC>:tabclose<CR>

" ------------------------------ "
"     mkdir on Save              "
" ------------------------------ "
function! s:CreateDirStructureOnSave(file, buf)
    if empty(getbufvar(a:buf, '&buftype')) && a:file!~#'\v^\w+\:\/'
        let dir=fnamemodify(a:file, ':h')
        if !isdirectory(dir)
            call mkdir(dir, 'p')
        endif
    endif
endfunction

augroup CreateDirOnSave
    autocmd!
    autocmd BufWritePre * :call s:CreateDirStructureOnSave(expand('<afile>'), +expand('<abuf>'))
augroup END


" ================================================= "
"            Plugin Settings                        "
" ================================================= "

" ------------------------------ "
"     Conque Terminal            "
" ------------------------------ "
    let g:ConqueTerm_CloseOnEnd = 1      " Close terminal on exit
    let g:ConqueTerm_InsertOnEnter = 1   " Enter terminal automatically
    let g:ConqueTerm_Color = 1           " 0 - no terminal colors
                                         " 1 - limited terminal colors
                                         " 2 - full color
    let g:ConqueTerm_TERM =  'xterm'     " TERM setting
    let g:ConqueTerm_ReadUnfocused = 1   " Read terminal even if unfocused
    let g:ConqueTerm_CWInsert = 1
    let g:ConqueTerm_StartMessages = 0   " Disable warning messages

" ----------------------------- "
"     PyLint Options            "
" ----------------------------- "
    let g:pylint_onwrite = 0                " Disable autorun on save
    let g:pylint_inline_highlight = 0       " Disable inline highlight
    let g:pylint_cwindow = 0
    autocmd! FileType python compiler pylint


" ------------------------------ "
"     SuperTab Plugin            "
" ------------------------------ "
    "let g:SuperTabDefaultCompletionType = '<C-TAB>' " YCM Completion
    "let g:SuperTabDefaultCompletionType = "context"
    "let g:SuperTabContextDefaultCompletionType = "<c-n>"
    "let g:SuperTabCompletionContexts = ['s:ContextText', 's:ContextDiscover']
    "let g:SuperTabContextTextOmniPrecedence = ['&omnifunc', '&completefunc']
    "let g:SuperTabContextDiscoverDiscovery = ["&completefunc:<c-x><c-u>", "&omnifunc:<c-x><c-o>"]

   let g:SuperTabDefaultCompletionType = 'context'
   let g:SuperTabCompletionContexts = ['s:ContextText', 's:ContextDiscover']
   let g:SuperTabLongestHighlight=1
   let g:SuperTabLongestEnhanced=1

" ------------------------------ "
"     NERDTree Settings          "
" ------------------------------ "
    map <leader>B :NERDTreeToggle<CR>
    " See colorscheme desert256 for colors
    


" Bug fix for vimplugin(Eclipse)
hi clear SignColumn


" ------------------------------ "
"     TaskList Settings          "
" ------------------------------ "
    let g:tlTokenList = ['FIXME', 'TODO', 'XXX', 'NEW', 'MODIFIED', 'CHANGED', 'DELETED']
    let g:tlWindowPosition = 1


" ------------------------------ "
"     FSwitch                    "
" ------------------------------ "
    au! BufEnter *.cpp     let b:fswitchdst = 'hpp,hxx,h' | let b:fswitchlocs = './'
    au! BufEnter *.hpp     let b:fswitchdst = 'cpp,cxx,c' | let b:fswitchlocs = './'
    au! BufEnter *.c       let b:fswitchdst = 'h,hpp,hxx' | let b:fswitchlocs = './'
    au! BufEnter *.h       let b:fswitchdst = 'cpp,c,cxx' | let b:fswitchlocs = './'
    au! BufEnter *.aspx    let b:fswitchdst = 'aspx.cs'   | let b:fswitchlocs = './'
    au! BufEnter *.aspx.cx let b:fswitchdst = 'aspx'      | let b:fswitchlocs = './'
    " Switch to file inplace
    nmap <silent> <Leader>of :FSHere<cr>
    " Switch to the file and load it into the window on the right >
    nmap <silent> <Leader>oL :FSRight<cr>
    " Switch to the file and load it into a new window split on the right >
    nmap <silent> <Leader>ol :FSSplitRight<cr>
    " Switch to the file and load it into the window on the left >
    nmap <silent> <Leader>oH :FSLeft<cr>
    " Switch to the file and load it into a new window split on the left >
    nmap <silent> <Leader>oh :FSSplitLeft<cr>
    " Switch to the file and load it into the window above >
    nmap <silent> <Leader>oK :FSAbove<cr>
    " Switch to the file and load it into a new window split above >
    nmap <silent> <Leader>ok :FSSplitAbove<cr>
    " Switch to the file and load it into the window below >
    nmap <silent> <Leader>oJ :FSBelow<cr>
    " Switch to the file and load it into a new window split below >
    nmap <silent> <Leader>oj :FSSplitBelow<cr>


" ------------------------------ "
"        TagBar                  "
" ------------------------------ "
    nmap <silent> <Leader>t :TagbarToggle<CR>


" ------------------------------ "
"     Error Marker Plugin        "
" ------------------------------ "
    let g:errormarker_errorgroup        = "ColorColumn"  " Text line color
    let g:errormarker_sign_errorgroup   = "ColorColumn"  " Margin sign color
    let g:errormarker_warninggroup      = "ModeMsg"      " Text line color
    let g:errormarker_sign_warninggroup = "ModeMsg"      " Margin sign color


" ------------------------------ "
"     OmniCppComplete            "
" ------------------------------ "
    "let g:omnicppcomplete_disabled = 1
    let OmniCpp_MayCompleteDot   = 0    " autocomplete with .
    let OmniCpp_MayCompleteArrow = 0    " autocomplete with ->
    let OmniCpp_MayCompleteScope = 0    " autocomplete with ::
    let OmniCpp_SelectFirstItem  = 2    " select first item (but don't insert)
    let OmniCpp_NamespaceSearch  = 2    " search namespaces in this and included files
    let OmniCpp_ShowPrototypeInAbbr = 1 " show function prototype (i.e. parameters) in popup 
    let OmniCpp_DefaultNamespaces   = ["std", "_GLIBCXX_STD"]
    let OmniCpp_DisplayMode = 1

    " Automatically close preview window on completion
    autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
    autocmd InsertLeave * if pumvisible() == 0|pclose|endif


" ------------------------------ "
"     ShowMarks                  "
" ------------------------------ "
    let g:showmarks_enable       = 1      " Enable/Disable ShowMarks
    let g:showmarks_textlower    = " "    " Margin format for lowercase marks
    let g:showmarks_textupper    = " "    " Margin format for upperase marks
    let g:showmarks_textother    = " "    " Margin format for other marks
    let g:showmarks_ignore_type  = "hqm"  " Ignore mark types
    let g:showmarks_ignore_name  = ""
    let g:showmarks_hlline_lower = "0"    " Highlight line for lowercase marks
    let g:showmarks_hlline_upper = "0"    " Highlight line for uppercase marks
    let g:showmarks_hlline_other = "0"    " Highlight line for other marks
    let g:showmarks_include      = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ" " Which marks to show in margin

    hi link ShowMarksHLl Comment
    hi link ShowMarksHLu Comment
    hi link ShowMarksHLo Comment
    hi link ShowMarksHLm Comment

" ------------------------------ "
"     CCTree                     "
" ------------------------------ "
    let g:CCTreeDisplayMode = 1          " Values: 1 -- Ultra-compact
                                         "         2 -- Compact
                                         "         3 -- Wide
    let g:CCTreeCscopeDb = "cscope.out"  " Cscope database file
    let g:CCTreeRecursiveDepth = 3       " Maximum call levels
    let g:CCTreeMinVisibleDepth = 3      " Maximum visible(unfolded) level
    let g:CCTreeOrientation = "botright" " Orientation of window

" ------------------------------ "
"     EClim                      "
" ------------------------------ "
    let g:EclimDefaultFileOpenAction   = 'vert belowright split'
    "let g:EclimCHierarchyDefaultAction = 'vert belowright split'
    let g:EclimProjectTreeSharedInstance = 1

    let g:TreeDirHighlight = 'WarningMsg'
    "let g:TreeFileHighlight = ''
    let g:TreeFileExecutableHighlight = 'SpecialKey'

    map <leader>eg  <ESC>:CSearchContext<CR>
    map <leader>et  <ESC>:ProjectTree<CR>
    map <leader>eo  <ESC>:ProjectOpen 
    map <leader>eO  <ESC>:ProjectClose<CR>
    map <leader>eh  <ESC>:CCallHierarchy<CR>

    "autocmd! FileType cpp  nnoremap <silent>  <cr> :CSearchContext<cr>
    autocmd! WinEnter \[Call\ Hierarchy\] wincmd L | vertical resize 40 " Automatically move quickfix to the right


" ------------------------------ "
"     PathoGen Loader            "
" ------------------------------ "
    let g:pathogen_disabled = ['jedi-vim']
    call pathogen#infect() 

" ------------------------------ "
"     AutoTag                    "
" ------------------------------ "
   "let g:autotagDisabled = 0
   "let g:autotagVerbosityLevel = 0
   "let g:autotagExcludeSuffixes = "tml.xml.text.txt"
   "let g:autotagCtagsCmd = "ctags"

   let g:autotagTagsFile = "tags.prom"


" ------------------------------ "
"     UltiSnips                  "
" ------------------------------ "
   "let g:UltiSnipsUsePythonVersion = 2           " Force Python version 2

  " if has("gui_running")
  "     let g:UltiSnipsExpandTrigger="<c-space>"
  " else
  "     let g:UltiSnipsExpandTrigger="<Nul>"
  " endif
   let g:UltiSnipsJumpForwardTrigger="<c-j>"
   let g:UltiSnipsJumpBackwardTrigger="<c-k>"

   let g:UltiSnipsEditSplit = "vertical"
   let g:UltiSnipsSnippetsDir = "~/.vim/snippets"
   let g:UltiSnipsSnippetDirectories = ["snippets", "UltiSnips"]

   map <leader>s <ESC>:UltiSnipsEdit<CR>

" ------------------------------ "
"     ProjectTags                "
" ------------------------------ "
    command! ProjectTags GenProTags
    command! ProjectTagsBg GenProTagsBg

" ------------------------------ "
"     BufferGator                "
" ------------------------------ "
    let g:buffergator_viewport_split_policy = "L"
    let g:buffergator_autodismiss_on_select = 1
    let g:buffergator_split_size = 40
    let g:buffergator_sort_regime = "bufnum" " (bufnum, basename, filepath, extension, mru)
    let g:buffergator_display_regime = "basename" " (basename | filepath | bufname)
    let g:buffergator_suppress_keymaps = 1

    map <leader>b <ESC>:BuffergatorTabsToggle<CR>

" ------------------------------ "
"     FuzzyFinder                "
" ------------------------------ "
    let g:fuf_keyOpen = '<C-l>'
    let g:fuf_keyOpenSplit = '<C-j>'
    let g:fuf_keyOpenVsplit = '<C-k>'
    let g:fuf_keyOpenTabpage = '<CR>'
    let g:fuf_keyPreview = '<C-@>'
    let g:fuf_keyNextMode = '<C-t>'
    let g:fuf_keyPrevMode = '<C-y>'
    let g:fuf_keyPrevPattern = '<C-s>'
    let g:fuf_keyNextPattern = '<C-_>'
    let g:fuf_keySwitchMatching = '<C-\><C-\>'

    map <leader>n <ESC>:FufCoverageFile<CR>

" ------------------------------ "
"     clang_complete             "
" ------------------------------ "
    let g:clang_auto_select = 1
    let g:clang_complete_auto  = 0
    let g:clang_snippets = 1
    let g:clang_snippets_engine = 'ultisnips'
    let g:clang_use_library = 1
    let g:clang_debug = 0
    let g:clang_complete_macros = 1

" ------------------------------ "
"     mark                       "
" ------------------------------ "
    let g:loaded_mark = 1 " Disable mark plugin

" ------------------------------ "
"    YouCompleteMe               "
" ------------------------------ "
    if has("win32")
       let g:loaded_youcompleteme = 1
    endif
    let g:ycm_key_invoke_completion = '<F6>'                       " Default completion key
  "  let g:ycm_key_list_select_completion = ['<C-TAB>', '<Down>']   " Changed caused conflict with UltiSnips
  "  let g:ycm_key_list_previous_completion = ['<C-S-TAB>', '<Up>'] " Changed caused conflict with UltiSnips
    let g:ycm_complete_in_comments = 0
    let g:ycm_complete_in_strings = 1
    let g:ycm_confirm_extra_conf = 1                               " Ask before loading .ycm_extra_conf.py
    let g:ycm_min_num_of_chars_for_completion = 1 
    let g:ycm_add_preview_to_completeopt = 0
    let g:ycm_autoclose_preview_window_after_completion = 0
    let g:ycm_ycm_extra_conf_name = 'ycm_project.py'
    let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/python/ycm_conf.py'
    let g:ycm_semantic_triggers =  {
        \   'c' : ['.', '->'],
        \   'objc' : ['->', '.'],
        \   'ocaml' : ['.', '#'],
        \   'cpp,objcpp' : ['.', '->', '::'],
        \   'perl' : ['->'],
        \   'php' : ['->', '::'],
        \   'cs,java,javascript,d,vim,ruby,python,perl6,scala,vb,elixir,go' : ['.'],
        \   'lua' : ['.', ':'],
        \   'erlang' : [':'],
        \ }
    let g:ycm_filetype_blacklist = {
        \ 'notes' : 1,
        \ 'markdown' : 1,
        \ 'text' : 1,
        \ 'conque_term': 1,
        \}

    map <leader>d :YcmCompleter GoToDefinitionElseDeclaration<CR>

" ------------------------------ "
"     mark                       "
" ------------------------------ "
   let g:loaded_quickfixstatus = 1  " Disable quickfixstatus plugin

" ------------------------------ "
"     Syntastic                  "
" ------------------------------ "
   if !has("win32")
       let g:syntastic_error_symbol='✗'
       let g:syntastic_warning_symbol='⚠'
   endif
   let g:syntastic_echo_current_error=1
   let g:syntastic_enable_signs=1
   let g:syntastic_always_populate_loc_list = 0
   let g:syntastic_always_populate_qf_list = 1

" ------------------------------ "
"     Syntastic                  "
" ------------------------------ "
   let g:jedi#show_function_definition = 0
   let g:jedi#popup_on_dot = 1
   let g:jedi#popup_select_first = 0
   "let g:jedi#auto_vim_configuration = 0
   hi link SyntasticWarning SyntasticWarningSign

" ------------------------------ "
"     Emmet                      "
" ------------------------------ "
    let g:user_emmet_expandabbr_key = "<c-y>y,"
    imap <C-e> <c-o>:call <SID>CallEmmet("EmmetExpandAbbr")<CR>
    nmap <C-e> :call emmet#expandAbbr(3,"")<cr>
    vmap <C-e> :call emmet#expandAbbr(2,"")<cr>
    function! s:CallEmmet(plug)
      call feedkeys("\<plug>(".a:plug.")")
    endfunction
