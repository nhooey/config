#!/bin/bash
# iwup
# bring up the wireless interface at home

ifconfig eth0 down
iwconfig eth1 essid marvellous
#iwconfig eth1 key c278e1769495c56f163dce993e open
iwconfig eth1 key a0196676e7ece076b3ca292de2 open
#iwconfig eth1 ap 00:13:A3:2E:52:36
iwconfig eth1 ap 00:13:A3:37:61:73
sleep 1s
iwconfig eth1

dhclient eth1
