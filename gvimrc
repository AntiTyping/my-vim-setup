" Font family and font size.
set guifont=Consolas:h14
set antialias                     " MacVim: smooth fonts.
set encoding=utf-8                " Use UTF-8 everywhere.
set guioptions-=T                 " Hide toolbar.

if has("gui_macvim")

  " Fullscreen takes up entire screen
  set fuoptions=maxhorz,maxvert

  macmenu &File.New\ Tab key=<nop>
  map <D-t> <Plug>PeepOpen

  " Command-Shift-F for Ack
  macmenu Window.Toggle\ Full\ Screen\ Mode key=<nop>
  map <D-F> :Ack<space>

  " Command-e for ConqueTerm
  map <D-e> :call StartTerm()<CR>

  " Command-/ to toggle comments
  map <D-/> <plug>NERDCommenterToggle<CR>

  " Command-Shift-T toggles NERDTree
  macmenu &File.Open\ Tab\.\.\. key=<nop>
  map <D-T> :NERDTreeToggle<CR>
  " Command-Shift-R find the current find in NERDTree
  map <D-R> :NERDTreeFind<CR>

endif
