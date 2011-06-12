" Example Vim configuration.
" Copy or symlink to ~/.vimrc or ~/_vimrc.

set nocompatible                  " Must come first because it changes other options.

call pathogen#infect()
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
set statusline=[%n]\ %<%.99f\ %h%w%m%r%y\ %{exists('*CapsLockStatusline')?CapsLockStatusline():''}%{fugitive#statusline()}%{SyntasticStatuslineFlag()}%=%-16(\ %l,%c-%v\ %)%P

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

" Command-T
map <D-t> :CommandT<CR>
" Automatically refresh command-t when VIM gains focus
autocmd FocusGained * :CommandTFlush
" Command-T configuration
let g:CommandTMaxHeight=20

" map Leader-e to :e <path of current file>
map <Leader>e :e <C-R>=expand("%:p:h") . "/" <CR>

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
autocmd BufNewFile * set noeol
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
autocmd User Rails.view.*erb set sw=4 sts=4
" Indent yaml
autocmd User Rails.config* set smartindent
" Expand tabs in javascript, force tab at 2 (Rails.javascript.coffee)
autocmd User Rails.javascript* set expandtab sw=2 sts=2
" Cucumber are indented by 2
autocmd User Rails.cucumber.feature* set sw=2 sts=2
" Add .mobile.erb and .pdf.erb as html syntax to vim-rails
autocmd BufNewFile,BufRead *.mobile.erb let b:eruby_subtype = 'html'
autocmd BufNewFile,BufRead *.pdf.erb let b:eruby_subtype = 'html'

" Clear the current search highlight by pressing Esc
nnoremap <silent> <esc> :noh<cr><esc>

" CTags - refresh tags on <Leader>rt
" jsctags was not that great --
" map <Leader>rt :!jsctags .;ctags -a -R --languages=-JavaScript *<CR><CR>
map <Leader>rt :!ctags -R *<CR><CR>

" Disable annoying middle-click paste feature
map <MiddleMouse> <Nop>
imap <MiddleMouse> <Nop>
map <2-MiddleMouse> <Nop>
imap <2-MiddleMouse> <Nop>
map <3-MiddleMouse> <Nop>
imap <3-MiddleMouse> <Nop>
map <4-MiddleMouse> <Nop>
imap <4-MiddleMouse> <Nop>

" CoffeeScript stuff
" Compile coffeescript on save (with -p so it does not save the .js, just check syntax for errors), show cwindow
":autocmd BufWritePost *.coffee silent CoffeeMake! -p | cwindow
map <Leader>c :CoffeeCompile<CR>

" NERDTree
" Command-T opens NERDTree
map <D-T> :NERDTreeToggle<CR>
" Command-Shift-R find the current find in NERDTree
map <D-R> :NERDTreeFind<CR>
" When opening vim, open the nerdtree window
autocmd VimEnter * NERDTree
" And restore focus to the right pane
autocmd VimEnter * wincmd p

" Syntastic
let g:syntastic_enable_signs=1
let g:syntastic_auto_loc_list=1
