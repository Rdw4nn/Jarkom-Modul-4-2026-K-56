#!/bin/bash

cat <<EOF > /etc/network/interfaces
auto eth0
iface eth0 inet static
    address 192.239.18.66
    netmask 255.255.255.252

auto eth1
iface eth1 inet static
    address 192.239.16.1
    netmask 255.255.255.0

auto eth2
iface eth2 inet static
    address 192.239.18.1
    netmask 255.255.255.192

auto eth3
iface eth3 inet static
    address 192.239.17.1
    netmask 255.255.255.0
EOF

ip addr flush dev eth0 2>/dev/null
ip addr add 192.239.18.66/30 dev eth0
ip link set eth0 up

ip addr flush dev eth1 2>/dev/null
ip addr add 192.239.16.1/24 dev eth1
ip link set eth1 up

ip addr flush dev eth2 2>/dev/null
ip addr add 192.239.18.1/26 dev eth2
ip link set eth2 up

ip addr flush dev eth3 2>/dev/null
ip addr add 192.239.17.1/24 dev eth3
ip link set eth3 up

sysctl -w net.ipv4.ip_forward=1

ip route replace default via 192.239.18.65
