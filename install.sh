#!/usr/bin/env bash

echo "
========================================================

Alex6 Basic Server Install script
this script will setup a base install for the Server

========================================================

Starting by updating apt and installing basic packages
"
sudo apt update -y
sudo apt upgrade -y
sudo apt install -y fastfetch tree curl wget git gh ca-certificates gnupg unzip zip tar xz-utils 7zip build-essential zsh tmux fzf ripgrep bat jq btop tree rsync 

echo "
Setting default shell to zsh
"
sudo chsh -s /usr/bin/zsh $SUDO_USER

echo "
Now downloading last version of nvim and installing from the tarball
"

cd ~
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
tar xzf nvim-linux-x86_64.tar.gz
mkdir -p ~/.local/opt ~/.local/bin
rm -rf ~/.local/opt/nvim
mv nvim-linux-x86_64 ~/.local/opt/nvim
ln -sf ~/.local/opt/nvim/bin/nvim ~/.local/bin/nvim
rm nvim-linux-x86_64.tar.gz

echo "
Installing server dotfiles
"
git clone https://github.com/AL3X-69/dotfiles
cd dotfiles
git checkout server
./cmgr.sh push

echo "
"

read -p "Is this a pve node? [Y/n]: " -n 1 -r < /dev/tty
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
    echo "
    Installing QEmu Guest Agent
    "
    sudo apt install qemu-guest-agent
    
    echo "
    Installing node_exporter
    "
    ./install_node_exporter.sh
fi

echo "
Done ! bye bye :3"

