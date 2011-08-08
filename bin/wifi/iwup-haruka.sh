ifconfig eth0 down
iwconfig eth1 essid kershaw11
iwconfig eth1 key c8535892dd09dc47e3f0ea6f57 open
iwconfig eth1 ap "00:13:A3:0F:6C:EB"
sleep 1s;

iwconfig eth1

dhclient eth1
