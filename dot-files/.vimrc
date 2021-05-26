set autoindent number autowrite showmatch shiftwidth=4 showmode tabstop=4 textwidth=70 ruler background=dark
set report=1
set nocompatible
filetype plugin on
filetype indent on
" show existing tab with 4 spaces width
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" On pressing tab, insert 4 spaces
set expandtab
syntax enable

abbr #b /************************************************
abbr #e ************************************************/
abbr #> #>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
abbr #< #<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
abbr _perl /usr/bin/env perluse strict;
abbr _python /usr/bin/env python
abbr _ggp warn '#' x 30,"\n",'*' x 4,"Gene Genealogy Project",'*' x 4,"\n","#" x 30,"\n";
abbr _ggp1 ****** Gene Genealogy Project ******
abbr _usage usage{	print <<USAGE;Author:  Zhenguo ZhangContact:  zhangz.sci\@gmail.comUSAGEexit 1;}
abbr _method  Title   :Usage   :Function:Returns :Args    :
" make the mouse active, more easier usage
" set mouse=a
set tags=~/Scripts/tags " tags useful for finding subroutines in different files
set exrc
syntax on

" definition of function
function! GNU()
	" Just read into the GNU license block
"	r ! sed "s/\#DATE\#/`date`/" ~/.gnu_license
endfunction

" Map the key to a command. Abbreviation can't be used to call
" functions
map <F10> :call GNU()<CR>
" the same as 'map <F10> <Esc>:call GNU()<CR>'

" the license for package
function! GNUP()
	" Just read into the GNU license block
"	r ! sed "s/\#DATE\#/`date`/" ~/.gnu_license_part
endfunction
map <F11> :call GNUP()<CR>

" a function to run a vim command and insert the output
"function! TabMessage(cmd)
"	redir => message
"	silent execute a:cmd
"	redir END
"	tabnew
"	silent put=message
"	set nomodified
"endfunction
"command! -nargs=+ -complete=command TabMessage call TabMessage(<q-args>)

" a function to get vim command output
"function! Output(cmd)
"	redir @z
"	silent execute a:cmd
"	redir END
"	"zp
"	silent put z
"endfunction
"map <F12> <Esc>:call Output(expand("<cword>"))<CR>
" <cword> is the word under current cursor

function! M_new()
"	r ~/.myperl/m_new
endfunction


" plugin sections
" see https://github.com/junegunn/vim-plug for more on vim plugins
call plug#begin('~/.vim/plugged')

" declare list of plugins
"
" support to R code
Plug 'jalvesaq/Nvim-R', {'branch': 'stable'}

call plug#end()
