autocmd VimEnter *
	\ if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
	\|	PlugInstall --sync | q
	\| endif

let g:ale_completion_enabled = 1
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:auto_save = 1
let g:auto_save_silent = 1
let g:airline#extensions#ale#enabled = 1
let g:airline_theme='simple'

call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-sensible'
Plug 'vim-scripts/vim-auto-save'
Plug 'dense-analysis/ale'
Plug 'ntpeters/vim-better-whitespace'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
call plug#end()

set number
set noshowmode

" yank to clipboard
if has("clipboard")
   set clipboard=unnamed " copy to the system clipboard

     if has("unnamedplus") " X11 support
         set clipboard+=unnamedplus
     endif
endif

set ttymouse=xterm2
set mouse=a
