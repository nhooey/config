#!/bin/bash
# iwup
# bring up the wireless interface at home

iwconfig eth1 key "s:ivanivan" open
iwconfig eth1 ap 00:04:E2:7F:8B:26

dhclient eth1
