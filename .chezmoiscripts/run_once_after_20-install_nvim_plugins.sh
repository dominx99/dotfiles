#!/usr/bin/env bash

name=$(cat /tmp/username)

vimplugininstall() {
	whiptail --infobox "Installing neovim plugins..." 7 60
	mkdir -p "/home/$name/.config/nvim/autoload"
	curl -Ls "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" >  "/home/$name/.config/nvim/autoload/plug.vim"
	chown -R "$name:wheel" "/home/$name/.config/nvim"
	sudo -u "$name" nvim -c "PackerCompile|q|q"
}

if [ ! -f "/home/$name/.config/nvim/autoload/plug.vim" ]; then
  vimplugininstall
fi
