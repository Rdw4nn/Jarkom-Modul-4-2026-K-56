#!/bin/bash

cat <<EOF > /etc/network/interfaces
auto eth0
iface eth0 inet static
    address 192.239.17.4
    netmask 255.255.255.0
    gateway 192.239.17.1
EOF

ip addr flush dev eth0 2>/dev/null
ip addr add 192.239.17.4/24 dev eth0
ip link set eth0 up
ip route replace default via 192.239.17.1 dev eth0

cat <<EOF > /etc/resolv.conf
nameserver 192.168.122.1
nameserver 8.8.8.8
EOF
