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

# Install zgen
if [ ! -d "/home/$name/.zgen" ]; then
  whiptail --infobox "Installing zgen..." 5 70
  sudo -u "$name" git clone https://github.com/tarjoilija/zgen.git "/home/$name/.zgen"
fi

# run service init if there is command "serviceinit"
serviceinit NetworkManager cronie docker

# Add user to docker group and mount cgroups
sudo usermod -aG docker $name

if [ -f /etc/sudoers.d/larbs-temp ]; then
  sudo rm /etc/sudoers.d/larbs-temp
fi
