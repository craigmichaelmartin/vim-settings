#!/bin/bash

if [ -f ~/.vimrc ] && [ ! -L ~/.vimrc ]
then
    echo "Backing up existing ~/.vimrc to ~/.vimrc.bak"
    mv ~/.vimrc ~/.vimrc.bak
fi
if [ -L ~/.vimrc ]
then
    echo "Already have ~/.vimrc symlink, we're good"
else
    echo "Creating symlink ~/.vimrc, which points to ~/.vim/vimrc"
    ln -s ~/.vim/vimrc ~/.vimrc
fi

VIMINFO_OWNER=$(stat -c "%U" ~/.viminfo)

if [ "$VIMINFO_OWNER" == "root" ]
then
    echo "Your .viminfo file is owned by root. Changing owner to $(whoami)"
    sudo chown $(whoami) ~/.viminfo
fi
git submodule init
git submodule update

git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

git submodule init
git submodule update

cd ~/.vim/bundle && git clone git://github.com/altercation/vim-colors-solarized.git
mkdir ~/.vim/colors && mv ~/.vim/bundle/vim-colors-solarized/colors/solarized.vim ~/.vim/colors/

mkdir -p ~/.vim/autoload ~/.vim/bundle && curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

cd ~/.vim/bundle && git clone --depth=1 https://github.com/scrooloose/syntastic.git

cd ~/.vim/bundle && git clone git://github.com/tpope/vim-fugitive.git && vim -u NONE -c "helptags vim-fugitive/doc" -c q

vim +BundleInstall! +qall

curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash -o ~/.git-completion.bash && echo "source ~/.git-completion.bash" >> ~/.bash_profile && source ~/.bash_profile
