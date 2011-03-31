#!/bin/bash
# iwup
# bring up the wireless interface at home

iwconfig eth1 essid Mipou
iwconfig eth1 key C47D5ED9CA7F2B605761801D0B open
iwconfig eth1 ap 00:0D:3A:25:7E:3D
sleep 1
iwconfig

dhclient eth1
