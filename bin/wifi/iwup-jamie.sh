#!/bin/bash
# iwup
# bring up the wireless interface at Jamie's house in Kingston

iwconfig eth1 essid brockster
iwconifg eth1 ap 00:12:17:0D:C3:C3
dhclient eth1
