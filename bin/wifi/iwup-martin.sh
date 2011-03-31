#!/bin/bash
# iwup
# bring up the wireless interface at home

iwconfig eth1 essid "Apple Network 0cbae1"
iwconfig eth1 key 's:LomjK>TOg%}SR' open
iwconfig eth1 ap 00:11:24:0C:BA:E1

sleep 1
iwconfig

dhclient eth1
