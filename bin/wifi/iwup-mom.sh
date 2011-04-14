#!/bin/bash
# iwup
# bring up the wireless interface at home

ifconfig eth0 down

prev_dir=`pwd`
cd /etc/waproamd/keys
iwconfig eth1 key 1D661B405742752E22A6449200 open
iwconfig eth1 essid network
cd "$prev_dir"

dhclient eth1
