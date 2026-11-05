#!/bin/bash

cat <<EOF > /etc/network/interfaces
auto eth0
iface eth0 inet static
    address 192.239.46.66
    netmask 255.255.255.248

auto eth1
iface eth1 inet static
    address 192.239.40.1
    netmask 255.255.252.0
EOF

ip addr flush dev eth0 2>/dev/null
ip addr add 192.239.46.66/29 dev eth0
ip link set eth0 up

ip addr flush dev eth1 2>/dev/null
ip addr add 192.239.40.1/22 dev eth1
ip link set eth1 up

sysctl -w net.ipv4.ip_forward=1

ip route replace default via 192.239.46.65
