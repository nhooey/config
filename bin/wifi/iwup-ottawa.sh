#!/bin/bash
# iwup
# bring up the wireless interface at home

ifconfig eth0 down
iwconfig eth1 essid linksys
iwconfig eth1 ap 00:0F:66:90:B1:93
sleep 1s
iwconfig eth1

dhclient eth1
