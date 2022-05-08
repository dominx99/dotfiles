up:
	@sudo systemctl disable dhcpcd
	@sudo systemctl stop dhcpcd
	@sudo ip address flush dev wlan0
	@sudo ip address add 192.168.0.124/24 broadcast + dev wlan0
	@echo "nameserver 8.8.8.8" | sudo tee /etc/resolv.conf
	@sudo ip route add default via 192.168.0.1
