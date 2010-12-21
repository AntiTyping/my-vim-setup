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

### Additional steps
You will need to manually setup a few things:

#### Ack
Install ack (macports):
    sudo port install p5-app-ack

#### Command-T
Make sure you switch to your system ruby (if using rvm)
    rvm system
then make:
    rake make

#### javascriptLint
You need to install lint for this plugin to work. Follow the instructions at [javascriptlint.com](http://www.javascriptlint.com/download.htm)

#### taglist
You need to replace the built-in gnu ctags with Exuberant Ctags:
    sudo port install ctags
I had to manually rename the system ctags to get it out of the way:
    sudo mv /usr/bin/ctags /usr/bin/ctags.old


