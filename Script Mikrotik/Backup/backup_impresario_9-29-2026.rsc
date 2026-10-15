# sep/29/2026 09:36:54 by RouterOS 6.49.13
# software id = DESA-RBEP
#
# model = RouterBOARD 750 r2
# serial number = 67D207FDA52F
/interface ethernet
set [ find default-name=ether1 ] comment=\
    "WAN || IndiBiz (Port 1)"
set [ find default-name=ether5 ] comment="LAN"
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
add address=192.168.1.30/24 comment=WAN interface=ether1 network=192.168.1.0
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
add action=dst-nat chain=dstnat comment=TENDA dst-address=10.128.2.19 \
    dst-port=8081 log=yes protocol=tcp to-addresses=192.168.50.253 to-ports=\
    80
add action=dst-nat chain=dstnat dst-port=8080 in-interface=\
    "sstp-out to JKT-DR3-RD1" protocol=tcp to-addresses=192.168.1.1 to-ports=\
    80
/ip route
add check-gateway=ping distance=5 gateway=192.168.1.1 routing-mark=Telkom
add check-gateway=ping distance=5 gateway=10.128.2.1 routing-mark=VPN
add check-gateway=ping distance=5 gateway=10.128.8.223 routing-mark=\
    VPN-JKT.APJ.RD1
add check-gateway=ping distance=5 gateway=10.255.0.1 routing-mark=\
    VPN-BTM.GPN.RD1
add distance=5 gateway=10.128.113.1 routing-mark=JKT.DR3.VPN
add check-gateway=ping distance=1 gateway=192.168.1.1
add check-gateway=ping distance=2 gateway=10.128.2.1
/ip route rule
add action=lookup-only-in-table src-address=192.168.1.0/24 table=Telkom
add src-address=10.128.2.19/32 table=VPN
add src-address=192.168.50.253/32 table=VPN
add dst-address=27.131.3.3/32 table=VPN
add dst-address=119.110.84.182/32 table=VPN
add src-address=10.128.8.224/32 table=VPN-JKT.APJ.RD1
add dst-address=119.110.84.173/32 table=VPN-JKT.APJ.RD1
add dst-address=27.131.3.3/32 table=VPN-JKT.APJ.RD1
add src-address=10.255.0.13/32 table=VPN-BTM.GPN.RD1
add dst-address=27.131.3.3/32 table=VPN-BTM.GPN.RD1
add dst-address=119.110.85.0/32 table=VPN-BTM.GPN.RD1
add src-address=10.128.113.8/32 table=JKT.DR3.VPN
/ip service
set telnet port=1441
set ftp disabled=yes
set www disabled=yes port=8080
set ssh port=1141
set api disabled=yes
set winbox port=8753
set api-ssl disabled=yes
/radius
add address=27.131.3.3 realm=MikroTik secret=radiussbpnet service=login
/snmp
set contact=noc.global@sbp.net.id enabled=yes location=Ciledug
/system clock
set time-zone-name=Asia/Makassar
/system identity
set name=MikroTik
/system logging
add action=disk topics=interface
add action=disk topics=script
/system ntp client
set enabled=yes primary-ntp=160.30.225.225 secondary-ntp=103.245.159.58
/tool graphing interface
add
/user aaa
set use-radius=yes
