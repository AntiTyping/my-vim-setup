" Font family and font size.
set guifont=Consolas:h14
set antialias                     " MacVim: smooth fonts.
set encoding=utf-8                " Use UTF-8 everywhere.
set guioptions-=T                 " Hide toolbar.

if has("gui_macvim")

  " Fullscreen takes up entire screen
  set fuoptions=maxhorz,maxvert

  " <D-T> and <D-B> are remapped
  macmenu &File.New\ Tab key=<nop>
  macmenu &Tools.Make key=<nop>

  " Command-Shift-F for Ack
  macmenu Window.Toggle\ Full\ Screen\ Mode key=<nop>
  map <D-F> :Ack<space>

  " Command-/ to toggle comments
  map <D-/> <plug>NERDCommenterToggle<CR>

  " Command-Shift-T toggles NERDTree
  macmenu &File.Open\ Tab\.\.\. key=<nop>

endif
