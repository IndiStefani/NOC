# feb/08/2026 03:27:21 by RouterOS 6.47.9
# software id = 96BM-RLNJ
#
# model = RB952Ui-5ac2nD
# serial number = CC3E0E163939
/interface ethernet
set [ find default-name=ether1 ] comment=WAN
set [ find default-name=ether5 ] comment=LAN.Customer
/interface wireless
set [ find default-name=wlan1 ] ssid=MikroTik
set [ find default-name=wlan2 ] ssid=MikroTik
/interface wireless security-profiles
set [ find default=yes ] supplicant-identity=MikroTik
/ip hotspot profile
set [ find default=yes ] html-directory=flash/hotspot
/ip pool
add name=dhcp_pool0 ranges=192.168.50.2-192.168.50.254
/ip dhcp-server
add address-pool=dhcp_pool0 disabled=no interface=ether5 name=dhcp1
/interface sstp-client
add connect-to=119.110.84.190 disabled=no name=sstp-out1-JKT.DR3.VPN \
    password=@WL&o4O*mP#R! profile=default-encryption user=tomoroCF-ambarukmo
add connect-to=119.110.84.173 disabled=no name=sstp-out2-JKT.APJ.RD1 \
    password=@WL&o4O*mP#R! profile=default-encryption user=tomoroCF-ambarukmo
add connect-to=119.110.85.0 disabled=no name=sstp-out3-BTM.GPN.RD1 password=\
    @WL&o4O*mP#R! profile=default-encryption user=tomoroCF-ambarukmo
/snmp community
set [ find default=yes ] addresses=27.131.0.0/24,27.131.3.0/24 name=sbpmrtg
/system logging action
set 1 disk-lines-per-file=10000
/ip address
add address=192.168.50.1/24 comment=LAN.Customer interface=ether5 network=\
    192.168.50.0
/ip dhcp-client
add disabled=no interface=ether1
/ip dhcp-server network
add address=192.168.50.0/24 gateway=192.168.50.1
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
add action=add-dst-to-address-list address-list=Sosmed address-list-timeout=\
    none-dynamic chain=forward disabled=yes protocol=tcp psd=4,3s,3,1
add action=add-src-to-address-list address-list="port scanners" \
    address-list-timeout=2w chain=input comment="NMAP NULL scan" protocol=tcp \
    tcp-flags=!fin,!syn,!rst,!psh,!ack,!urg
add action=drop chain=input comment="dropping port scanners" \
    src-address-list="port scanners"
add action=add-src-to-address-list address-list="port scanners" \
    address-list-timeout=2w chain=input comment="NMAP NULL scan" protocol=tcp \
    tcp-flags=!fin,!syn,!rst,!psh,!ack,!urg
add action=drop chain=input comment="dropping port scanners" \
    src-address-list="port scanners"
add action=add-dst-to-address-list address-list=Sosmed address-list-timeout=\
    none-dynamic chain=forward disabled=yes protocol=tcp psd=4,3s,3,1
add action=add-src-to-address-list address-list="port scanners" \
    address-list-timeout=2w chain=input comment="NMAP NULL scan" protocol=tcp \
    tcp-flags=!fin,!syn,!rst,!psh,!ack,!urg
add action=drop chain=input comment="dropping port scanners" \
    src-address-list="port scanners"
add action=add-src-to-address-list address-list="port scanners" \
    address-list-timeout=2w chain=input comment="ALL/ALL scan" protocol=tcp \
    tcp-flags=fin,syn,rst,psh,ack,urg
add action=add-src-to-address-list address-list="port scanners" \
    address-list-timeout=2w chain=input comment="NMAP NULL scan" protocol=tcp \
    tcp-flags=!fin,!syn,!rst,!psh,!ack,!urg
add action=drop chain=input comment="dropping port scanners" \
    src-address-list="port scanners"
add action=add-dst-to-address-list address-list=Sosmed address-list-timeout=\
    none-dynamic chain=forward disabled=yes protocol=tcp psd=4,3s,3,1
add action=add-src-to-address-list address-list="port scanners" \
    address-list-timeout=2w chain=input comment="NMAP NULL scan" protocol=tcp \
    tcp-flags=!fin,!syn,!rst,!psh,!ack,!urg
add action=drop chain=input comment="dropping port scanners" \
    src-address-list="port scanners"
/ip firewall nat
add action=masquerade chain=srcnat
add action=dst-nat chain=dstnat disabled=yes dst-port=8080 in-interface=\
    sstp-out1-JKT.DR3.VPN protocol=tcp to-addresses=192.168.50.254 to-ports=\
    80
/ip route
add distance=5 gateway=10.10.29.1 routing-mark=tunnel
add distance=5 gateway=10.128.8.241 routing-mark=JKT.APJ.RD1
add distance=5 gateway=10.255.0.1 routing-mark=BTM.GPN.RD1
/ip route rule
add src-address=10.128.113.0/24 table=tunnel
add dst-address=27.131.3.3/32 table=tunnel
add src-address=10.128.8.242/32 table=JKT.APJ.RD1
add dst-address=27.131.3.3/32 table=JKT.APJ.RD1
add src-address=10.255.0.22/32 table=BTM.GPN.RD1
add dst-address=27.131.3.3/32 table=BTM.GPN.RD1
/ip service
set telnet address="119.110.84.173/32,119.110.86.222/32,119.110.82.44/32,45.11\
    5.64.0/24,119.110.84.190/32,192.168.100.0/27" port=1441
set ftp disabled=yes
set www disabled=yes port=8080
set ssh address="119.110.84.173/32,119.110.86.222/32,119.110.82.44/32,45.115.6\
    4.0/24,119.110.84.190/32,192.168.100.0/27" port=1141
set api disabled=yes
set winbox port=8753
set api-ssl disabled=yes
/radius
add address=27.131.3.3 realm=Mikrotik secret=radiussbpnet service=login
/snmp
set contact=noc.global@sbp.net.id enabled=yes location=Ciledug
/system clock
set time-zone-name=Asia/Jakarta
/system identity
set name=TomoroCF_Ambarukmo-Plaza
/system logging
add action=disk topics=interface
add action=disk topics=script
/system ntp client
set enabled=yes primary-ntp=103.169.192.230 secondary-ntp=27.131.0.138
/tool netwatch
add down-script="log info \"10.92.246.80 Hop 2 via CTN Down\"" host=\
    10.92.246.80 up-script="log info \"10.92.246.80 Hop 2 via CTN Up\""
add down-script="log info \"172.16.100.1 Hop 3 via CTN Down\"" host=\
    172.16.100.1 up-script="log info \"172.16.100.1 Hop 3 via CTN Up\""
add down-script="log info \"123.108.9.111 - JAKARTA-IIX RS2 Down\"" host=\
    123.108.9.111 up-script="log info \"123.108.9.111 - JAKARTA-IIX RS2 Up\""
add down-script="log info \"123.108.8.111 - JAKARTA-IIX RS1 Down\"" host=\
    123.108.8.111 up-script="log info \"123.108.8.111 - JAKARTA-IIX RS1 Up\""
add down-script="log info \"8.8.8.8 via CTN Down\"" host=8.8.8.8 up-script=\
    "log info \"8.8.8.8 via CTN Up\""
add down-script="log info \"1.1.1.1 via CTN Down\"" host=1.1.1.1 up-script=\
    "log info \"1.1.1.1 via CTN Up\""
add down-script="log info \"192.168.1.1 Hop 1 via CTN Down\"" host=\
    192.168.1.1 up-script="log info \"192.168.1.1 Hop 1 via CTN Up\""
/user aaa
set use-radius=yes
