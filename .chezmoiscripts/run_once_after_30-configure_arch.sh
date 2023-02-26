#!/usr/bin/env bash

name=$(cat /tmp/username)

serviceinit() { for service in "$@"; do
	dialog --infobox "Enabling \"$service\"..." 4 40
	systemctl enable "$service"
	systemctl start "$service"
	done ;}

resetpulse() { dialog --infobox "Reseting Pulseaudio..." 4 50
	killall pulseaudio
	sudo -u "$name" pulseaudio --start ;}

rmmod pcspkr
sudo echo "blacklist pcspkr" > /etc/modprobe.d/nobeep.conf

# Make zsh the default shell for the user.
sudo chsh -s /bin/zsh "$name" >/dev/null 2>&1
sudo -u "$name" mkdir -p "/home/$name/.cache/zsh/"
sudo -u "$name" mkdir -p "/home/$name/.config/abook/"
sudo -u "$name" mkdir -p "/home/$name/.config/mpd/playlists/"

# dbus UUID must be generated for Artix runit.
dbus-uuidgen > /var/lib/dbus/machine-id

# Use system notifications for Brave on Artix
echo "export \$(dbus-launch)" > /etc/profile.d/dbus.sh

# Enable tap to click
[ ! -f /etc/X11/xorg.conf.d/40-libinput.conf ] && printf 'Section "InputClass"
        Identifier "libinput touchpad catchall"
        MatchIsTouchpad "on"
        MatchDevicePath "/dev/input/event*"
        Driver "libinput"
	# Enable left mouse button by tapping
	Option "Tapping" "on"
EndSection' >/etc/X11/xorg.conf.d/40-libinput.conf

[ -f /usr/bin/pulseaudio ] && resetpulse

# run service init if there is command "serviceinit"
serviceinit NetworkManager cronie docker

# Install zgen
if [ ! -d "/home/$name/.zgen" ]; then
  whiptail --infobox "Installing zgen..." 5 70
  sudo -u "$name" git clone https://github.com/tarjoilija/zgen.git "/home/$name/.zgen"
fi

# Add user to docker group and mount cgroups
sudo usermod -aG docker $name

echo "%wheel ALL=(ALL:ALL) ALL" >/etc/sudoers.d/00-larbs-wheel-can-sudo
echo "%wheel ALL=(ALL:ALL) NOPASSWD: /usr/bin/shutdown,/usr/bin/reboot,/usr/bin/systemctl suspend,/usr/bin/wifi-menu,/usr/bin/mount,/usr/bin/umount,/usr/bin/pacman -Syu,/usr/bin/pacman -Syyu,/usr/bin/pacman -Syyu --noconfirm,/usr/bin/loadkeys,/usr/bin/pacman -Syyuw --noconfirm,/usr/bin/pacman -S -u -y --config /etc/pacman.conf --,/usr/bin/pacman -S -y -u --config /etc/pacman.conf --" >/etc/sudoers.d/01-larbs-cmds-without-password
echo "Defaults editor=/usr/bin/nvim" >/etc/sudoers.d/02-larbs-visudo-editor
mkdir -p /etc/sysctl.d
echo "kernel.dmesg_restrict = 0" > /etc/sysctl.d/dmesg.conf

[ -f /etc/sudoers.d/larbs-temp ] && rm /etc/sudoers.d/larbs-temp
