#iwconfig eth1 ap 00:04:E2:C2:C5:BE
#iwconfig eth1 key 4628eeb2670b25d78e990f1e12
iwconfig eth1 essid Blarg
iwconfig eth1 ap 00:04:E2:C2:C5:BE
iwconfig eth1 key DEADBEEFDEADBEEFDEADBEEFDE
sleep 1s
iwconfig
dhclient eth1
