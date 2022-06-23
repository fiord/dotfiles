#!/bin/sh
cd ~/dotfiles && git submodule update --init --recursive
cd ~/dotfiles/.vim/dein/repos/github.com/neoclide/coc.nvim && yarn install

ln -sf ~/dotfiles/.vimrc ~/.vimrc
ln -sf ~/dotfiles/.vim ~/.vim
ln -sf ~/dotfiles/.viminfo ~/.viminfo
ln -sf ~/dotfiles/.bash_profile ~/.bash_profile
ln -sf ~/dotfiles/.bashrc ~/.bashrc
ln -sf ~/doftiles/.config ~/.config

cd ~/dotfiles/.config/nvim && sh ./installer.sh ~/.vim/dein
