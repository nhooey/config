#!/bin/bash

iwconfig eth1 essid university
iwconfig eth1 ap 00:13:C3:58:D2:11
dhclient eth1
echo "User: mzyssmsc"
echo "Pass: monday19"
