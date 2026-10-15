
/interface ethernet
set [ find default-name=ether1 ] comment="WAN || IndiBiz (Port 1)"
set [ find default-name=ether5 ] comment=LAN
/interface wireless security-profiles
set [ find default=yes ] supplicant-identity=MikroTik
/ip pool
add name=dhcp_pool0 ranges=192.168.50.2-192.168.50.254
/ip dhcp-server
add address-pool=dhcp_pool0 disabled=no interface=ether5 name=dhcp1
/snmp community
set [ find default=yes ] addresses=27.131.0.0/24,27.131.3.0/24 name=sbpmrtg
/system logging action
set 1 disk-lines-per-file=10000
/interface sstp-server server
set keepalive-timeout=30
/ip address
add address=192.168.50.1/24 comment=LAN interface=ether5 network=192.168.50.0
add address=10.131.80.34/30 comment="PTP.BLI.CNI.RD1 || Private" disabled=yes \
    interface=ether1 network=10.131.80.32
add address=10.11.12.143/24 interface=ether1 network=10.11.12.0
/ip dhcp-client
add interface=ether1
/ip dhcp-server network
add address=192.168.50.0/24 gateway=192.168.50.1
/ip dns
set servers=27.131.3.254,27.131.5.254,8.8.8.8
/ip firewall address-list
add address=119.110.86.222 list=ACCESS-ROUTER
add address=119.110.84.41 list=ACCESS-ROUTER
add address=119.110.82.44 list=ACCESS-ROUTER
/ip firewall filter
add action=reject chain=input comment=CONTENT content=user.dat reject-with=\
    icmp-network-unreachable
add action=add-src-to-address-list address-list="port scanners" \
    address-list-timeout=2w chain=input comment="Port scanners to list " \
    protocol=tcp psd=21,3s,3,1
add action=add-src-to-address-list address-list="port scanners" \
    address-list-timeout=2w chain=input comment="NMAP FIN Stealth scan" \
    protocol=tcp tcp-flags=fin,!syn,!rst,!psh,!ack,!urg
add action=add-src-to-address-list address-list="port scanners" \
    address-list-timeout=2w chain=input comment="SYN/FIN scan" protocol=tcp \
    tcp-flags=fin,syn
add action=add-src-to-address-list address-list="port scanners" \
    address-list-timeout=2w chain=input comment="SYN/RST scan" protocol=tcp \
    tcp-flags=syn,rst
add action=add-src-to-address-list address-list="port scanners" \
    address-list-timeout=2w chain=input comment="FIN/PSH/URG scan" protocol=\
    tcp tcp-flags=fin,psh,urg,!syn,!rst,!ack
add action=add-src-to-address-list address-list="port scanners" \
    address-list-timeout=2w chain=input comment="ALL/ALL scan" protocol=tcp \
    tcp-flags=fin,syn,rst,psh,ack,urg
add action=add-src-to-address-list address-list="port scanners" \
    address-list-timeout=2w chain=input comment="NMAP NULL scan" protocol=tcp \
    tcp-flags=!fin,!syn,!rst,!psh,!ack,!urg
add action=drop chain=input comment="dropping port scanners" \
    src-address-list="port scanners"
add action=drop chain=forward protocol=udp src-address=146.88.240.0/24
add action=drop chain=forward protocol=tcp src-address=146.88.240.0/24
add action=drop chain=input protocol=udp src-address=146.88.240.0/24
add action=drop chain=input protocol=tcp src-address=146.88.240.0/24
add action=drop chain=forward content=zeroday dst-port=80 protocol=tcp
add action=drop chain=output content=zeroday dst-port=80 protocol=tcp
add action=add-src-to-address-list address-list=ACCESS-ROUTER \
    address-list-timeout=1h chain=input comment=KNOCKING packet-size=1028 \
    protocol=icmp
add action=drop chain=input dst-port=8753,1141,1441 protocol=tcp \
    src-address-list=!ACCESS-ROUTER
/ip firewall nat
add action=masquerade chain=srcnat src-address=192.168.50.0/24
add action=dst-nat chain=dstnat comment=LAN dst-address=10.128.2.19 dst-port=\
    8081 log=yes protocol=tcp to-addresses=192.168.50.253 to-ports=80
/ip route
add check-gateway=ping distance=1 gateway=10.11.12.1
/system clock
set time-zone-name=Asia/Makassar
