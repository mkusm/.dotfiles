# APPS
sudo ./conf_files/install-apps.sh

# BASH, TMUX
cp conf_files/git-prompt.sh ~/.git-prompt.sh
cp conf_files/git-completion.bash ~/.git-completion.bash
cp conf_files/bashrc ~/.bashrc
cp conf_files/tmux.conf ~/.tmux.conf

# VIM
cp conf_files/vimrc ~/.vimrc
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
mkdir ~/.vim/backup
echo "Remember to run :PluginInstall inside vim!"
