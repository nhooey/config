#!/bin/bash
# iwup
# bring up the wireless interface at home

ifconfig eth0 down
iwconfig eth1 key 64d546d8e6 open
iwconfig eth1 essid "MAC & CHEESE"

dhclient eth1
