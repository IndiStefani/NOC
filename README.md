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