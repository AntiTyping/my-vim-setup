# My Vim setup


## Steps for installation

1. Clone this repo
        $ git clone git://github.com/fpbouchard/my-vim-setup.git
2. Fetch all submodules
        $ cd my-vim-setup
        $ git submodule update --init
3. Instead of copying files around, link to them:
        $ cd ~
        $ ln -s <path to repo>/vimrc .vimrc
        $ ln -s <path to repo>/gvimrc .gvimrc
        $ ln -s <path to repo>/vim .vim
