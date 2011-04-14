#!/bin/bash

ifconfig eth0 down
iwconfig eth1 key a7238f596e4115c1390db7ac79 open
iwconfig eth1 essid wireless
sleep 1s

iwconfig eth1

dhclient eth1
