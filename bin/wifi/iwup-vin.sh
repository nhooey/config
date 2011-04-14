#!/bin/bash
# iwup
# bring up the wireless interface at home

iwconfig eth1 key 2273449BC5A688EFC251C003A2 open
iwconfig eth1 ap 00:0D:3A:25:7E:3D
sleep 1
iwconfig

dhclient eth1
