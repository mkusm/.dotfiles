# APPS
sudo ./conf_files/install-apps-alternative.sh

# BASH, TMUX
cp conf_files/git-prompt.sh ~/.git-prompt.sh
cp conf_files/git-completion.bash ~/.git-completion.bash
cp conf_files/bashrc ~/.bashrc
cp conf_files/tmux.conf ~/.tmux.conf

# copy gnome-terminal settings to enable tmux by default, need fixing
# cp -r conf_files/gconf ~/.gconf

# VIM
cp conf_files/vimrc ~/.vimrc
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
mkdir ~/.vim/backup
