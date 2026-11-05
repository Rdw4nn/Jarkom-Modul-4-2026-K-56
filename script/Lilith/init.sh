#!/bin/bash

cat <<EOF > /etc/network/interfaces
auto eth0
iface eth0 inet static
    address 192.239.4.2
    netmask 255.255.255.128
    gateway 192.239.4.1
EOF

ip addr flush dev eth0 2>/dev/null
ip addr add 192.239.4.2/25 dev eth0
ip link set eth0 up
ip route replace default via 192.239.4.1 dev eth0

cat <<EOF > /etc/resolv.conf
nameserver 192.168.122.1
nameserver 8.8.8.8
EOF
