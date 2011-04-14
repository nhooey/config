#!/bin/bash
iwconfig eth1 essid Hannah
iwconfig eth1 key 's:hannahisloopy'
iwconfig eth1 ap 00:0D:0B:AE:04:D7
sleep 1s
iwconfig eth1
dhclient eth1
