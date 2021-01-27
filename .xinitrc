#!/bin/sh

setbg &		# Set the background
sxhkd &		# Bind keys
# Switch to US international with Caps as Mod/Escape
#setxkbmap -option caps:super -variant altgr-intl && killall xcape 2>/dev/null ; xcape -e 'Super_L=Escape' &
setxkbmap pl -option caps:super && killall xcape 2>/dev/null ; xcape -e 'Super_L=Escape' &
xmodmap -e 'keycode 135 = Super_R' & # properties button extra Mod/Escape
xset r rate 300 50 & # Speed xrate up
unclutter & # Remove mouse when idle
xcompmgr & # xcompmgr for transparency
dunst & # notifications
# trayer --expand true --widthtype request --edge top --align right --margin 5 --SetPartialStrut false --height 18 --transparent true & # standalone tray
nm-applet & # network support
blueman-applet & # bluetooth support

# allow access to clipboard for docker neovim
xhost local:root

# authentication
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
/usr/bin/gnome-keyring-daemon --start --components=secrets &
/etc/X11/xinit/xinitrc.d/50-systemd-user.sh

xflux -l 51.1287859 -g 16.9915022 -k 3400

# status bar
while :; do
    dwmbar &
	ssh-agent dwm || break
done
