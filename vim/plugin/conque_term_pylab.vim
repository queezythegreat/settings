" FILE:     plugin/conque_term_pylab.vim {{{
" AUTHOR:   Gökhan Sever
"           Nico Raffo <nicoraffo@gmail.com>
" MODIFIED: 2010-04-05
" VERSION:  0.1, for Vim 7.0
" LICENSE:
" }}}
"
" Summary: Ipython shortcuts contributed by Gökhan Sever
" 
" Installation: place this file in your .vim/plugin/ directory.
" 

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Key mappings {{{

" create a new ipython buffer below
nnoremap <F6> :cd %:p:h<CR> :<C-U>call conque_term#open('ipython -pylab', ['belowright vsplit'])<CR>

" run the current buffer in ipython
nnoremap <silent> <F5> :<C-U>call conque_term_pylab#ipython_run()<CR>

" }}}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Functions {{{

" run the current buffer in ipython
function! conque_term_pylab#ipython_run()
    let cmd = "run " . expand("%:t")
    silent execute 'python ' . g:ConqueTerm_Var . '.write(''' . cmd . ''' + "\n")'
    startinsert!
endfunction 

" }}}

