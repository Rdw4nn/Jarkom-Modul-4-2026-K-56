#!/bin/bash

cat <<EOF > /etc/network/interfaces
auto eth0
iface eth0 inet static
    address 192.239.48.130
    netmask 255.255.255.252

auto eth1
iface eth1 inet static
    address 192.239.10.1
    netmask 255.255.255.252

auto eth2
iface eth2 inet static
    address 192.239.18.65
    netmask 255.255.255.252

auto eth3
iface eth3 inet static
    address 192.239.46.65
    netmask 255.255.255.248
EOF

ip addr flush dev eth0 2>/dev/null
ip addr add 192.239.48.130/30 dev eth0
ip link set eth0 up

ip addr flush dev eth1 2>/dev/null
ip addr add 192.239.10.1/30 dev eth1
ip link set eth1 up

ip addr flush dev eth2 2>/dev/null
ip addr add 192.239.18.65/30 dev eth2
ip link set eth2 up

ip addr flush dev eth3 2>/dev/null
ip addr add 192.239.46.65/29 dev eth3
ip link set eth3 up

sysctl -w net.ipv4.ip_forward=1

ip route replace default via 192.239.48.129
ip route replace 192.239.0.0/20 via 192.239.10.2
ip route replace 192.239.16.0/22 via 192.239.18.66
ip route replace 192.239.32.0/21 via 192.239.46.68
ip route replace 192.239.40.0/22 via 192.239.46.66
ip route replace 192.239.44.0/22 via 192.239.46.67
