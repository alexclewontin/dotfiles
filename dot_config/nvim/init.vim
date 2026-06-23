" Reuse the existing Vim runtime and config as Neovim's single source of truth.
set runtimepath^=~/.vim
set runtimepath+=~/.vim/after
let &packpath = &runtimepath

" Neovim does not support 'ttymouse'; keep the existing cursor-shape intent natively.
set guicursor=n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20,a:blinkon0

let s:vimrc = expand('~/.vimrc')
if filereadable(s:vimrc)
  let s:filtered_vimrc = tempname()
  call writefile(
        \ filter(readfile(s:vimrc), 'v:val !~# ''^\s*set\s\+ttymouse=''') ,
        \ s:filtered_vimrc,
        \ )
  execute 'source' fnameescape(s:filtered_vimrc)
  call delete(s:filtered_vimrc)
  unlet s:filtered_vimrc
endif
unlet s:vimrc
