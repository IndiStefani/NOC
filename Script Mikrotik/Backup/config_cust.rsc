# sep/29/2026 10:30:12 by RouterOS 6.49
# software id = 3LCL-1YUH
#
# model = RouterBOARD 3011UiAS
# serial number = 8EED089018F3
/interface ethernet
set [ find default-name=ether1 ] comment=UPLINK.NNI.ONT
set [ find default-name=ether5 ] comment=NNI.Next-Level-Karoke.SW1.GE1/0/1.1G
/ip pool
add name=dhcp_pool0 ranges=10.0.0.51-10.0.0.252
add name=dhcp_pool1 ranges=192.168.5.2-192.168.5.254
add name=dhcp_pool6 ranges=192.168.20.2-192.168.20.254
/ip dhcp-server
# Interface not running
add address-pool=dhcp_pool0 interface=ether5 lease-time=10m name=dhcp1
add address-pool=dhcp_pool1 interface=ether4 name=dhcp2
/snmp community
set [ find default=yes ] addresses=27.131.0.0/24,27.131.3.0/24 name=sbpmrtg
/system logging action
set 1 disk-lines-per-file=10000
/ip firewall connection tracking
set udp-timeout=10s
/ip address
add address=10.0.0.254/24 comment=LAN.IP-Private interface=ether5 network=\
    10.0.0.0
add address=10.131.80.34/30 comment="PTP.BLI.CNI.RD1 || Private" interface=\
    ether1 network=10.131.80.32
add address=119.110.82.6/30 comment="PTP.BLI.CNI.RD1 || Public" interface=\
    ether1 network=119.110.82.4
add address=192.168.5.1/24 interface=Ether5.VLAN-05.Network-Management \
    network=192.168.5.0
add address=192.168.20.1/24 interface=ether4 network=192.168.20.0
/ip dhcp-server network
add address=10.0.0.0/24 dns-server=8.8.8.8,27.131.0.188 gateway=10.0.0.254
add address=192.168.5.0/24 gateway=192.168.5.1
add address=192.168.20.0/24 dns-server=8.8.8.8,27.131.0.188 gateway=\
    192.168.20.1
/ip dns
set allow-remote-requests=yes cache-size=100048KiB servers=\
    27.131.0.188,27.131.3.199
/ip firewall address-list
add address=10.0.0.0/24 list=LAN-IP.Private
add address=192.168.5.0/24 list=LAN-IP.Private
add address=192.168.20.0/24 list=LAN-IP.Private
/ip firewall nat
add action=masquerade chain=srcnat src-address-list=LAN-IP.Private
add action=dst-nat chain=dstnat dst-address=119.110.82.18 dst-port=8080 \
    protocol=tcp to-addresses=192.168.20.231 to-ports=80
/ip ipsec profile
set [ find default=yes ] dpd-interval=2m dpd-maximum-failures=5
/ip proxy
set cache-on-disk=yes cache-path=CF/web-proxy max-cache-object-size=10240KiB
/ip route
add check-gateway=ping comment=DF-SBPNet disabled=no distance=2 dst-address=\
    0.0.0.0/0 gateway=119.110.82.17
/ip service
set ftp disabled=yes
set telnet disabled=yes
set ssh address=119.110.82.44/32,119.110.86.222/32,119.110.84.41/32 port=1141
set www disabled=yes port=8080
set api disabled=yes
set api-ssl disabled=yes
set winbox address=119.110.82.44/32,119.110.86.222/32,119.110.84.41/32 port=\
    8753
/radius add address=27.131.3.3 realm=MikroTik service=login timeout=300ms
/routing bfd configuration
add disabled=no interfaces=all min-rx=200ms min-tx=200ms multiplier=5
/snmp
set contact=noc.global@sbp.net.id enabled=yes location=Ciledug
/system clock
set time-zone-name=Asia/Bali
/system identity
set name=FuramaXclusive_Resort
/system logging
add action=disk topics=interface
add action=disk topics=script
/system ntp client
set enabled=yes
/system ntp client servers
add address=27.131.3.180
/system package update
set channel=long-term
/user aaa
set use-radius=yes
