sudo apt-get -f install \
    qbittorrent \
    python3-pip \
    git \
    tree \
    vim \
    nautilus-dropbox \
    "gnome-do" \
    tmux \
    xcape \
    
# Spotify
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys BBEBDCB318AD50EC6865090613B00F1FD2C19886
echo deb http://repository.spotify.com stable non-free | sudo tee /etc/apt/sources.list.d/spotify.list
sudo apt-get update
sudo apt-get install spotify-client

# Keepassxc
sudo apt-get -f install snapd
sudo snap install keepassxc
cp ~/Dropbox/development/settings/conf_files/keepassxc.ini ~/snap/keepassxc/current/.config/keepassxc/keepassxc.ini
