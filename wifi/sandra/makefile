up:
	@sudo systemctl disable dhcpcd
	@sudo systemctl stop dhcpcd
	@sudo ip address flush dev wlo1
	@sudo ip address add 192.168.1.186/24 broadcast + dev wlo1
	@sudo ip route del 192.168.1.0/24 dev wlo1
	@sudo ip link set dev wlo1 down
	@sudo ip link set dev wlo1 up
	@sudo ip route add default via 192.168.1.1
