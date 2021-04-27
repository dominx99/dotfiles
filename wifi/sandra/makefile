up:
	@sudo systemctl disable dhcpcd
	@sudo systemctl stop dhcpcd
	@sudo ip address flush dev wlo1
	@sudo ip address add 192.168.1.154/24 broadcast + dev wlo1
	@echo "nameserver 192.168.1.1" | sudo tee /etc/resolv.conf
	@sudo ip route add default via 192.168.1.1
