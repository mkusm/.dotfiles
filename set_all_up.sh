cp conf_files/bashrc ~/.bashrc
cp conf_files/vimrc ~/.vimrc
cp conf_files/tmux.conf ~/.tmux.conf
cp conf_files/git-prompt.sh ~/.git-prompt.sh
cp conf_files/git-completion.bash ~/.git-completion.bash
cp -r conf_files/gconf ~/.gconf
sudo ./conf_files/install-apps-alternative.sh
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
