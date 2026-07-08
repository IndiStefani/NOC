# OLT GPON

## Menampilkan vlan di GPoN
`show gpon profile tcont`

## Melihat informasi kartu sfp
`show card`
`show system-group`

## Menampilkan informasi jam
`show clock`

## Melakukan restart 1 card pon
`reset-card slotno`

## Melihat status perangkat
`show running interface gpon-onu_1/1/12:17`



# Extra Mikrotik

## Cari berdasarkan comment
`/ip address set` 

## Failover dengan Netwatch
`/ip firewall nat enable [/ip firewall nat find comment="game-roblox-27.131.1.1"] /ip address enable [/ip address find comment ="Petro-China_2405171543"]`


# Switch Cisco

## Melihat status route
`show route 18.168.116.121`

## Melihat detail status receiver pada interface
`show interface ethernet 1/40 transceiver details`

## Melihat detail konfigurasi interface
`show interface ethernet 1/40`
`show interface eth1/40 switchport`

## Melihat routing BGP untuk ip destination
`show bgp summary | match (ip addres tujuan)`

## Melihat informasi lengkap mengenai status dan statistik interface
`display interface XGigabitEthernet 0/0/37`

`display interface gi 0/0/4`

## Menampilkan routing BGP
`show route advertising-protocol bgp 175.184.239.189`

## Menampilkan informasi sesi BGP dengan neighbor yang memiliki IP
`show bgp summary | match 175.184.239.189`

## Menampilkan informasi detail mengenai satu neighbor BGP
`show bgp neighbor 175.184.239.189`

## Menampilkan routing di detail routing untuk ip
 `show route 45.115.65.193`

 ##
 `ping -vpn-instance underlay_(1/2) 8.8.8.8`

 ##
 `display interface brief`
 `display ip interface brief`

 ### Saat ada laporan "internet down", urutan pengecekan yang umum adalah:

1. Cek status interface `(display interface / show interfaces)`.
2. Cek apakah IP interface masih benar `(display ip interface brief / show ip interface brief)`.
3. Ping gateway atau next-hop.
4. Cek routing `(display ip routing-table / show ip route)`. Jika menggunakan BGP, cek sesi BGP (display bgp peer / show bgp summary).
5. Lakukan `traceroute` untuk melihat jalur paket.
6. Periksa log `(display logbuffer / show logging)`.
7. Jika menggunakan fiber, cek kondisi optik `(display transceiver / show interfaces transceiver detail)`.