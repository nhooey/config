#!/bin/bash
# iwup
# bring up the wireless interface at home

ifconfig eth0 down
iwconfig eth1 essid hooey
iwconfig eth1 key "s:1234567890123" open
iwconfig eth1 ap 00:0D:88:98:1F:DE
sleep 1s
iwconfig eth1

dhclient eth1
