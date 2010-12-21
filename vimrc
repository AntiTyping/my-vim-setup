" Example Vim configuration.
" Copy or symlink to ~/.vimrc or ~/_vimrc.

set nocompatible                  " Must come first because it changes other options.

call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

syntax enable                     " Turn on syntax highlighting.
filetype plugin indent on         " Turn on file type detection.

set showcmd                       " Display incomplete commands.
set showmode                      " Display the mode you're in.

set backspace=indent,eol,start    " Intuitive backspacing.

set hidden                        " Handle multiple buffers better.

set wildmenu                      " Enhanced command line completion.
set wildmode=list:longest         " Complete files like a shell.
set wildignore+=log/**
set wildignore+=tmp/**

set ignorecase                    " Case-insensitive searching.
set smartcase                     " But case-sensitive if expression contains a capital letter.

set number                        " Show line numbers.
set ruler                         " Show cursor position.

set incsearch                     " Highlight matches as you type.
set hlsearch                      " Highlight matches.

set nowrap                        " Turn off line wrapping.
set scrolloff=3                   " Show 3 lines of context around the cursor.

set title                         " Set the terminal's title

set visualbell                    " No beeping.

set nobackup                      " Don't make a backup before overwriting a file.
set nowritebackup                 " And again.
set directory=$HOME/.vim/tmp//,.  " Keep swap files in one location

set tabstop=2                    " Global tab width.
set shiftwidth=2                 " And again, related.
set expandtab                    " Use spaces instead of tabs

set laststatus=2                  " Show the status line all the time
" Useful status information at bottom of screen
set statusline=[%n]\ %<%.99f\ %h%w%m%r%y\ %{exists('*CapsLockStatusline')?CapsLockStatusline():''}%{fugitive#statusline()}%=%-16(\ %l,%c-%v\ %)%P

" Enable folding
set foldmethod=syntax

" Enable a fold column
set foldcolumn=1

" Don't fold stuff by default
set foldlevelstart=99

" Highlight line under the cursor
set cursorline

colorscheme railscasts-fp

" Show tabs, trailing whitespaces, extends and precedes
set listchars=tab:>-,trail:·,extends:>,precedes:<
set list

" map Command-B to bufexplorer
nnoremap <C-B> :BufExplorer<cr>

" Show relative paths in BufExplorer
let g:bufExplorerShowRelativePath=1

" Command-T configuration
let g:CommandTMaxHeight=20

" Always remove trailing whitespace when saving file
autocmd BufWritePre * :%s/\s\+$//e

"jump to last cursor position when opening a file
"dont do it when writing a commit log entry
autocmd BufReadPost * call SetCursorPosition()
function! SetCursorPosition()
    if &filetype !~ 'commit\c'
        if line("'\"") > 0 && line("'\"") <= line("$")
            exe "normal! g`\""
            normal! zz
        endif
    end
endfunction

" Big magic bunch of code to prevent adding EOL to non-binary files
augroup EOL
autocmd!
autocmd BufWritePre * call EolSavePre()
autocmd BufWritePost * call EolSavePost()
augroup END

" If no eol at end of file, set binary so no eol will be added
function! EolSavePre()
let b:save_bin = &bin
if ! &eol
let &l:bin = 1
endif
endfunction

" Restore binary flag
function! EolSavePost()
let &l:bin = b:save_bin
endfunction
" END of eol bunch of code

" Automatic fold settings for specific files. Uncomment to use.
autocmd FileType ruby setlocal foldmethod=syntax
autocmd FileType css  setlocal foldmethod=indent shiftwidth=2 tabstop=2


" Automatically refresh command-t when VIM gains focus
autocmd FocusGained * :CommandTFlush

" Clear the current search highlight by pressing Esc
nnoremap <esc> :noh<return><esc>

" CTags
map <Leader>rt :!ctags --extra=+f -R *<CR><CR>

