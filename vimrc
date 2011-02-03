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

set softtabstop=2
set shiftwidth=2
set expandtab                     " Use spaces instead of tabs

set laststatus=2                  " Show the status line all the time
" Useful status information at bottom of screen
set statusline=[%n]\ %<%.99f\ %h%w%m%r%y\ %{exists('*CapsLockStatusline')?CapsLockStatusline():''}%{fugitive#statusline()}%=%-16(\ %l,%c-%v\ %)%P

" Enable folding (commented out since it really slows the rendering)
" set foldmethod=syntax
set nofoldenable

" Enable a fold column
" set foldcolumn=1

" Don't fold stuff by default
" set foldlevelstart=99

" Highlight line under the cursor -- commented since it really slows down the
" rendering
" set cursorline

colorscheme jellybeans-fp

" Show tabs, trailing whitespaces, extends and precedes
set listchars=tab:>-,trail:·,extends:>,precedes:<
set list

" map Command-B to bufexplorer
nnoremap <C-B> :BufExplorer<cr>

" Show relative paths in BufExplorer
let g:bufExplorerShowRelativePath=1

" Command-T configuration
let g:CommandTMaxHeight=20

" Always remove trailing whitespace before writing the buffer
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

" We are stuck with a non-Rails standard shiftwidth of 4 in our html.erb files :(
" See: https://github.com/tpope/vim-rails/issues/unreads#issue/33
" See: :help rails-'shiftwidth' & :help rails-autocommands
:autocmd User Rails.view.*erb set sw=4 sts=4
" Indent yaml
:autocmd User Rails.config* set smartindent
" Expand tabs in javascript
:autocmd User Rails.javascript* set expandtab


" Automatically refresh command-t when VIM gains focus
autocmd FocusGained * :CommandTFlush

" Clear the current search highlight by pressing Esc
nnoremap <esc> :noh<return><esc>

" CTags - refresh tags on <Leader>rt
" jsctags was not that great -- map <Leader>rt :!jsctags .;ctags -a -R --languages=-JavaScript *<CR><CR>
map <Leader>rt :!ctags -R *<CR><CR>

