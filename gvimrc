" Example Vim graphical configuration.
" Copy to ~/.gvimrc or ~/_gvimrc.

set guifont=BitStream\ Vera\ Sans\ Mono\ Bold:h13            " Font family and font size.
set antialias                     " MacVim: smooth fonts.
set encoding=utf-8                " Use UTF-8 everywhere.
set guioptions-=T                 " Hide toolbar.
"set background=light              " Background.
set lines=25 columns=100          " Window dimensions.

if has("gui_macvim")
  macmenu &File.New\ Tab key=<nop>
  map <D-t> :CommandT<CR>
endif

" Uncomment to use.
" set guioptions-=r                 " Don't show right scrollbar


