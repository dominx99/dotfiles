#!/bin/sh

# Adds `~/.bin` and all subdirectories to $PATH
export PATH="$PATH:$(du "$HOME/.bin/" | cut -f2 | tr '\n' ':' | sed 's/:*$//')"
export NEOVIM_DIR="/opt/nvim"
export EDITOR="nvim"
export TERMINAL="st"
export BROWSER="chromium"
export READER="zathura"
export FILE="vifm"
export SUDO_ASKPASS="$HOME/.bin/dmenupass"
export GTK2_RC_FILES="$HOME/.config/gtk-2.0/gtkrc-2.0"
export XDG_CONFIG_HOME="$HOME/.config"
export SUDO_PROMPT="$(printf "\033[1;31m")[sudo]$(printf "\033[0m") password for %p: "
export SSH_AUTH_SOCK=/run/user/1000/keyring/ssh
export INPUTRC="$HOME/.config/inputrc"

# less/man colors
export LESS=-R
export LESS_TERMCAP_mb="$(printf '%b' '[1;31m')"; a="${a%_}"
export LESS_TERMCAP_md="$(printf '%b' '[1;36m')"; a="${a%_}"
export LESS_TERMCAP_me="$(printf '%b' '[0m')"; a="${a%_}"
export LESS_TERMCAP_so="$(printf '%b' '[01;44;33m')"; a="${a%_}"
export LESS_TERMCAP_se="$(printf '%b' '[0m')"; a="${a%_}"
export LESS_TERMCAP_us="$(printf '%b' '[1;32m')"; a="${a%_}"
export LESS_TERMCAP_ue="$(printf '%b' '[0m')"; a="${a%_}"
export PYTHONPATH="/usr/bin/python"
export GOPATH="/go"

echo "$0" | grep "zsh$" >/dev/null && [ -f ~/.zshrc ] && source "$HOME/.zshrc"

# Start graphical server if not already running.
[ "$(tty)" = "/dev/tty1" ] && ! pgrep -x dwm >/dev/null && exec startx
