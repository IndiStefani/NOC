# feb/11/2026 01:58:25 by RouterOS 6.49.13
# software id = DESA-RBEP
#
# model = RouterBOARD 750 r2
# serial number = 67D207FDA52F
/interface bridge
add name=bridge1-LAN
/interface ethernet
set [ find default-name=ether1 ] comment=ISP1
set [ find default-name=ether2 ] comment=ISP2
/interface wireless security-profiles
set [ find default=yes ] supplicant-identity=MikroTik
/ip hotspot profile
set [ find default=yes ] html-directory=hotspot
/ip pool
add name=dhcp_pool0 ranges=172.31.200.2-172.31.200.254
/ip dhcp-server
add address-pool=dhcp_pool0 disabled=no interface=bridge1-LAN name=dhcp1
/snmp community
set [ find default=yes ] addresses=27.131.0.0/24,27.131.3.0/24 name=sbpmrtg
/system logging action
set 1 disk-lines-per-file=10000
/tool user-manager customer
set admin access=\
    own-routers,own-users,own-profiles,own-limits,config-payment-gw
/interface bridge port
add bridge=bridge1-LAN interface=ether5
add bridge=bridge1-LAN interface=ether4
/ip address
add address=172.31.200.1/24 interface=bridge1-LAN network=172.31.200.0
/ip dhcp-client
add add-default-route=no disabled=no interface=ether1
add add-default-route=no disabled=no interface=ether2
/ip dhcp-server network
add address=172.31.200.0/24 gateway=172.31.200.1
/ip dns
set servers=27.131.3.254,27.131.5.254,8.8.8.8
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
/ip firewall mangle
add action=accept chain=prerouting disabled=yes dst-address=192.168.1.0/24
add action=accept chain=prerouting dst-address=172.31.200.0/24
add action=mark-connection chain=prerouting in-interface=ether1 \
    new-connection-mark=ISP1 passthrough=yes
add action=mark-connection chain=prerouting in-interface=ether2 \
    new-connection-mark=ISP2 passthrough=yes
add action=mark-connection chain=prerouting in-interface=bridge1-LAN \
    new-connection-mark=ISP1 passthrough=yes per-connection-classifier=\
    both-addresses:2/0
add action=mark-connection chain=prerouting in-interface=bridge1-LAN \
    new-connection-mark=ISP2 passthrough=yes per-connection-classifier=\
    both-addresses:2/1
add action=accept chain=prerouting dst-address=192.168.1.0/24
add action=mark-routing chain=prerouting connection-mark=ISP1 in-interface=\
    bridge1-LAN new-routing-mark=ke-ISP1 passthrough=yes
add action=mark-routing chain=prerouting connection-mark=ISP2 in-interface=\
    bridge1-LAN new-routing-mark=ke-ISP2 passthrough=yes
add action=mark-routing chain=output connection-mark=ISP1 new-routing-mark=\
    ke-ISP1 passthrough=yes
add action=mark-routing chain=output connection-mark=ISP2 new-routing-mark=\
    ke-ISP2 passthrough=yes
/ip firewall nat
add action=masquerade chain=srcnat out-interface=ether1
add action=masquerade chain=srcnat out-interface=ether2
/ip route
add check-gateway=ping distance=1 gateway=192.168.1.1%ether1 routing-mark=\
    ke-ISP1
add check-gateway=ping distance=2 gateway=192.168.1.1%ether2 routing-mark=\
    ke-ISP2
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
set name=TestLoadBalance
/system logging
add action=disk topics=interface
add action=disk topics=script
/system ntp client
set enabled=yes primary-ntp=27.131.3.254 secondary-ntp=27.131.0.138
/tool graphing interface
add
/tool mac-server
set allowed-interface-list=none
/tool user-manager database
set db-path=flash/user-manager
/user aaa
set use-radius=yes
