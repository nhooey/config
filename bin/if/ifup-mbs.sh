#!/bin/bash
# ifup-mbs

ifconfig eth0 down
ifconfig eth0 130.88.6.207
route add default gw 130.88.6.250 eth0

echo "nameserver 130.88.13.7" > /etc/resolv.conf
echo "nameserver 130.88.203.7" >> /etc/resolv.conf
