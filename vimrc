" =========================== "
" QueezyTheGreat's VIMRC file "
" =========================== "
    set nocompatible  " Enable no compatibilety with vi
    set laststatus=2  " Staus bar always visible
    set backspace=2   " Enable backspace do delete previous characters 
    set shortmess=Imnrwx
    set noswf
    "set guifont=Lucida\ Console\ Semi-Condensed\ 12
    set guioptions=


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

    set scrolloff=5                         " 3 lines of offset when scrolling
    set showcmd                             " Show parcial commands in the status line
    set showmode                            " Show current mode which VIM is in

    set wildmode=longest:full,list          " Tab completion command mode
    set completeopt=longest,menu,preview    " Tab completion insert mode

    set nostartofline                       " Don't jump to begining of the line

    set iskeyword=@,48-57,_,192-255,-,.,@-@

    set whichwrap=<,>,h,l,b                 " Allow navigation with line wrapping

" ------------------------------ "
"     Indent Folding Options     "
" ------------------------------ "
    set foldenable        " Enables folding
    set foldmethod=indent " Sets the folding method

    set bufhidden=hide    " Hide buffer when not in window

" ------------------------------ "
"     File Type Dectection       "
" ------------------------------ "
    filetype on           " Enable file type detection
    filetype plugin on    " Loads plugins associated with file type 


" ------------------------------ "
"     File Type Dectection       "
" ------------------------------ "
    set nobackup          " Disable bakups of files
    set nowritebackup     " Disable writing backup files


" ------------------------------ "
"     MiniBufferExplorer         "
" ------------------------------ "
    " Settings
    let g:miniBufExplMapWindowNavVim = 1  " Enable window nawigation using hjkl
    let g:miniBufExplorerMoreThanOne = 0  " Always display MiniBufferExplorer
    let g:miniBufExplModSelTarget    = 1  " Force opening tabs in modifiable

" ------------------------------ "
"     Conque Terminal            "
" ------------------------------ "
    let g:ConqueTerm_CloseOnEnd = 1      " Close terminal on exit
    let g:ConqueTerm_InsertOnEnter = 1   " Enter terminal automatically
    let g:ConqueTerm_Color = 1           " 0 - no terminal colors
                                         " 1 - limited terminal colors
                                         " 2 - full color
    "let g:ConqueTerm_TERM =  'xterm'     " TERM setting
    let g:ConqueTerm_ReadUnfocused = 1   " Read terminal even if unfocused
    let g:ConqueTerm_CWInsert = 1

" ----------------------------- "
"     PyLint Options            "
" ----------------------------- "
    let g:pylint_onwrite = 0                " Disable autorun on save
    autocmd! FileType python compiler pylint

" ----------------------------- "
"     TList Options             "
" ----------------------------- "
    let Tlist_Compact_Format = 1            " Tlist compact View
    "let Tlist_Show_One_File  = 1           " Display tags for current buffer only.
    let Tlist_Auto_Update    = 1            " Update Tlist with new tags.
    "let Tlist_File_Fold_Auto_Close = 1      " Fold files not in current view.
    let Tlist_GainFocus_On_ToggleOpen = 0   " Don't focus Tlist window on toggle.
    let Tlist_Use_Right_Window = 1          " Right side alignment

" ------------------------------ "
"     Keyboard Mappings          "
" ------------------------------ "
    cabbr Q qa
    cabbr tlt TlistToggle
    imap <C-C> <Esc>vb~wa
    noremap <space> za

" ------------------------------ "
"     Session Saving             "
" ------------------------------ "
"set sessionoptions=blank,buffers,curdir,folds,help,resize,tabpages,winsize
"map <c-q> :mksession! ~/.vim/.session <cr>
"map <c-s> :source ~/.vim/.session <cr>


" ------------------------------ "
"  Python Development Settings   "
" ------------------------------ "
    " Python completion function
    autocmd FileType python set omnifunc=pythoncomplete#Complete

    " See colorscheme desert256 for highlight settings


" ------------------------------ "
"      Trac Plugin Settings      "
" ------------------------------ "
    let g:tracServerList = {}
    let g:tracServerList['QTZ'] = 'http://queezy@192.168.4.1/repos/login/xmlrpc' 

    " Full is buggy with minibuffer
    let g:tracWikiStyle     = 'bottom'
    let g:tracSearchStyle   = 'left'
    let g:tracTimelineStyle = 'bottom'
    let g:tracTicketStyle   = 'right'

    let g:tracTicketBriefDescription = 1

    " Setting size of Trac Ticket sidebar
    au WinEnter TICKETTOC_WINDOW resize 15
    au WinEnter TICKETTOC_WINDOW vertical resize 55

    au WinEnter TICKETTOC_WINDOW setlocal nonumber wrap
    au WinEnter TICKET_WINDOW setlocal nonumber wrap 
    au WinEnter TICKET_COMMENT_WINDOW setlocal nonumber wrap
    "au WinEnter TICKET_COMMENT_WINDOW resize 10
    
    au WinEnter TICKETTOC_WINDOW setlocal statusline=Ticket\ TOC
    au WinEnter TICKET_WINDOW setlocal statusline=Ticket\ Window
    au WinEnter TICKET_COMMENT_WINDOW setlocal statusline=Comment\ Window


    " Setting shortcuts
    map <leader>to :TTOpen<CR>
    map <leader>ts :TTSet

    map <leader>tc :TClose<CR>

    "map <leader>ws :TWServer QTZ<CR>
    "map <leader>wo :TWOpen<CR>
    "map <leader>wa :TWAddAttachment
    "map <leader>wc :TWCreate


" ------------------------------ "
"       NERDTree Settings        "
" ------------------------------ "
    map <leader>b :NERDTreeToggle<CR>
    " See colorscheme desert256 for colors
    

" ------------------------------ "
"        Window Navigation       "
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
"          Tab Settings          "
" ------------------------------ "
if exists("+tabline")

    " Tab navigation
    map <C-N> :tabnext<CR>
    map <C-P> :tabprev<CR>

    map <leader>1 :tabnext 1<CR>
    map <leader>2 :tabnext 2<CR>
    map <leader>3 :tabnext 3<CR>
    map <leader>4 :tabnext 4<CR>
    map <leader>5 :tabnext 5<CR>
    map <leader>6 :tabnext 6<CR>
    map <leader>7 :tabnext 7<CR>
    map <leader>8 :tabnext 8<CR>
    map <leader>9 :tabnext 9<CR>
    map <leader>0 :tabnext 10<CR>

    " See colorscheme desert256 for colors

    " Command abbriviations
    cabbr t tabnew

    " Custom Tab display function
    set tabline=%!MyTabLine()
    " Always display the tab line
    set showtabline=2


    function GetTabPrefix(tabNum)
        return a:tabNum . '  '
    endfunction

    function GetTabName(tabNum)
        " filename for current window in tab, without path
        let bufferName = fnamemodify( bufname(tabpagebuflist(a:tabNum )[tabpagewinnr(a:tabNum ) - 1]), ':t')
        " if empty, display [No Name]
        if bufferName == ''
            let bufferName = '[No Name]'
        endif
        return bufferName
    endfunction

    function RawTabName(tabNum)
        let tabName  = ' '
        let tabName .= GetTabPrefix(a:tabNum)
        let tabName .= GetTabName(a:tabNum)
        let tabName .= ' |'

        return tabName
    endfunction

    function GetTabPrefixHighlight(tabNum)
        if a:tabNum == tabpagenr()
            " Highlight active tab number with User2
            return '%2*'
        else
            " Highlight inactive tab number with User1
            return '%1*'
        endif
    endfunction

    function GetTabNameHighlight(tabNum)
        if a:tabNum == tabpagenr()
            " Highlight active tab name with TabLineSel
            return '%#TabLineSel#'
        else
            " Highlight inactive tab name with TabLine
            return '%#TabLine#'
        endif
    endfunction

    function ConstructTabName(tabNum)
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

    function MyTabLine()
        let tabLinePrefix = ' '. tabpagenr('$')
        while len(tabLinePrefix) < &numberwidth
            let tabLinePrefix .= ' '
        endwhile
        
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
    let &statusline="   %f  %<%=%(|  %M  %)%(|  %R  %)%0*|  %{&ff}  %(|  %W  %)%(|  %Y  %)| %4l %3v    %3p%% "


" Bug fix for vimplugin(Eclipse)
hi clear SignColumn


" ------------------------------ "
"       TaskList Settings        "
" ------------------------------ "
    let g:tlTokenList = ['FIXME', 'TODO', 'XXX', 'NEW', 'MODIFIED', 'CHANGED', 'DELETED']
    let g:tlWindowPosition = 1


" ------------------------------ "
"         Screen Title           "
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


au! BufEnter *.cpp let b:fswitchdst = 'hpp,hxx,h' | let b:fswitchlocs = './'
au! BufEnter *.hpp let b:fswitchdst = 'cpp,cxx,c' | let b:fswitchlocs = './'
au! BufEnter *.c   let b:fswitchdst = 'h,hpp,hxx' | let b:fswitchlocs = './'
au! BufEnter *.h   let b:fswitchdst = 'c,cpp,cxx' | let b:fswitchlocs = './'
" Switch to the file and load it into the current window >
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


map <silent> <F2> <ESC>:make!<CR>

nmap <silent> <Leader>t :TagbarToggle<CR>


" ------------------------------ "
"     QuickFix Window            "
" ------------------------------ "
let g:QFix_Win_Height = 10

nmap <silent> <Leader>q :QFix<CR>

" toggles the quickfix window.
command -bang -nargs=? QFix call QFixToggle(<bang>0)
function! QFixToggle(forced)
  if exists("g:qfix_win") && a:forced == 0
    cclose
  else
    execute "copen " . g:QFix_Win_Height
  endif
endfunction

" used to track the quickfix window
augroup QFixToggle
 autocmd!
 autocmd BufWinEnter quickfix let g:qfix_win = bufnr("$")
 autocmd BufWinLeave * if exists("g:qfix_win") && expand("<abuf>") == g:qfix_win | unlet! g:qfix_win | endif
augroup END
