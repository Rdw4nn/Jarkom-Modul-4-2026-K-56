#!/bin/bash

cat <<EOF > /etc/network/interfaces
auto eth0
iface eth0 inet static
    address 192.239.0.162
    netmask 255.255.255.252

auto eth1
iface eth1 inet static
    address 192.239.0.65
    netmask 255.255.255.252

auto eth2
iface eth2 inet static
    address 192.239.0.129
    netmask 255.255.255.224
EOF

ip addr flush dev eth0 2>/dev/null
ip addr add 192.239.0.162/30 dev eth0
ip link set eth0 up

ip addr flush dev eth1 2>/dev/null
ip addr add 192.239.0.65/30 dev eth1
ip link set eth1 up

ip addr flush dev eth2 2>/dev/null
ip addr add 192.239.0.129/27 dev eth2
ip link set eth2 up

sysctl -w net.ipv4.ip_forward=1

ip route replace default via 192.239.0.161
ip route replace 192.239.0.0/25 via 192.239.0.66
