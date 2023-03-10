alias dotf "git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"
alias rcli "source $HOME/.config/fish/config.fish"
alias ka="killall"
alias mkd="mkdir -pv"
alias lsall="ls -lahN --color=auto --group-directories-first"
alias copy="xclip -selection clipboard"
alias x="exit"
alias c="clear"
alias ecli="$EDITOR ~/.config/fish/config.fish"
alias rm='echo "This is not the command you are looking for."; false'
alias ia='comm -23 <(pacman -Qqett | sort) <(pacman -Qqg base -g base-devel | sort | uniq)'
alias t='trash'
alias rofi_dmenu='rofi -dmenu'
alias ssh="TERM=xterm-256color /usr/bin/ssh"
alias sshpass="TERM=xterm-256color /usr/bin/sshpass"
alias cat="bat"
alias chrome="google-chrome-stable"
alias google-chrome="google-chrome-stable"
alias installed-programs=" pacman -Qi | egrep '^(Name|Installed)' | cut -f2 -d':' | paste - - | column -t | sort -nrk 2 | grep MiB | less"
alias awsume="source (which awsume.fish)"
alias excel="sc-im"
