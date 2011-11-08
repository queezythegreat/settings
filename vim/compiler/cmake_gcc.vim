" Vim compiler file
" Compiler:         GNU C Compiler
" Maintainer:       Nikolai Weibull <now@bitwi.se>
" Latest Revision:  2010-10-14

if exists("current_compiler")
  finish
endif
let current_compiler = "cmake_gcc"

let s:cpo_save = &cpo
set cpo-=C

CompilerSet errorformat=
      \%-G%.%#\ Built\ target\ %.%#,
      \%-GScanning\ dependencies\ of\ target\ %.%#,
      \%-GLinking\ CXX\ static\ library\ %.%#,
      \%-GLinking\ CXX\ executable\ %.%#,
      \%*[^\"]\"%f\"%*\\D%l:%c:\ %m,
      \%*[^\"]\"%f\"%*\\D%l:\ %m,
      \\"%f\"%*\\D%l:%c:\ %m,
      \\"%f\"%*\\D%l:\ %m,
      \%-G%f:%l:\ %trror:\ (Each\ undeclared\ identifier\ is\ reported\ only\ once,
      \%-G%f:%l:\ %trror:\ for\ each\ function\ it\ appears\ in.),
      \%f:%l:%c:\ %trror:\ %m,
      \%f:%l:%c:\ %tarning:\ %m,
      \%f:%l:%c:\ %m,
      \%f:%l:\ %trror:\ %m,
      \%f:%l:\ %tarning:\ %m,
      \%f:%l:\ %m,
      \\"%f\"\\,\ line\ %l%*\\D%c%*[^\ ]\ %m,
      \%-G%*\\a[%*\\d]:\ Entering\ directory\ `%f',
      \%-G%*\\a[%*\\d]:\ Leaving\ directory\ `%f',
      \%-G%*\\a:\ Entering\ directory\ `%f',
      \%-G%*\\a:\ Leaving\ directory\ `%f',
      \%DMaking\ %*\\a\ in\ %f

if exists('g:compiler_gcc_ignore_unmatched_lines')
  CompilerSet errorformat+=%-G%.%#
endif

let &cpo = s:cpo_save
unlet s:cpo_save
