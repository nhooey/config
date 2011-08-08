#!/bin/bash
# iwup
# bring up the wireless interface in Waterloo

ifconfig eth0 down
iwconfig eth1 key "9054710236" open
iwconfig eth1 ap "00:13:46:07:6E:F6"
iwconfig eth1 essid FireHouse
sleep 1s

iwconfig eth1

dhclient eth1
