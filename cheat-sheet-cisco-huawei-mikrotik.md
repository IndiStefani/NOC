# Cheat Sheet: Cisco, Huawei, MikroTik (Terpisah per Vendor)

---

## CISCO IOS

### Navigasi Dasar
```
configure terminal          # masuk config mode
end / exit                  # keluar config mode
show running-config         # lihat config aktif
write memory                # simpan config (atau: copy run start)
interface GigabitEthernet0/0
reload                      # reboot device
show version                # versi & hardware
```

### Interface & Status Fisik
```
show ip interface brief
show interfaces GigabitEthernet0/0
show interfaces counters errors
show interfaces description
ip address 192.168.1.1 255.255.255.0
```

### CPU & Memory
```
show processes cpu sorted
show processes memory sorted
show environment
```

### Routing
```
show ip route
show ip route summary
show ip bgp summary
show ip bgp neighbors
show ip ospf neighbor
```

### Logging & History
```
show logging
logging host 192.168.1.100
show logging | include %LINK
```

### Neighbor Discovery
```
show cdp neighbors detail
show lldp neighbors detail
```

### SNMP
```
snmp-server community public RO
snmp-server location "Server Room Lantai 2"
snmp-server host 192.168.1.100 version 2c public
```

### NetFlow / Traffic Monitoring
```
flow exporter MONITOR-EXPORT
flow monitor MONITOR-MON
show interfaces | include rate
```

### Firewall Cepat Cek
```
show access-lists
show ip nat translations
```

### Command "Sapu Jagat" Harian
```
show ip interface brief
show interfaces status
show processes cpu sorted
show ip route summary
show logging | last 20
show cdp neighbors
```

---

## HUAWEI VRP

### Navigasi Dasar
```
system-view                          # masuk config mode
quit                                  # keluar config mode
display current-configuration         # lihat config aktif
save                                   # simpan config
interface GigabitEthernet0/0/1
reboot                                 # reboot device
display version                        # versi & hardware
```

### Interface & Status Fisik
```
display interface brief
display interface GigabitEthernet0/0/1
display interface | include error
display interface description
ip address 192.168.1.1 24
```

### CPU & Memory
```
display cpu-usage
display memory-usage
display environment
```

### Routing
```
display ip routing-table
display ip routing-table statistics
display bgp peer
display bgp peer verbose
display ospf peer
```

### Logging & History
```
display logbuffer
info-center loghost 192.168.1.100
display logbuffer | include DOWN
```

### Neighbor Discovery
```
display lldp neighbor brief
```
(Huawei jarang pakai CDP karena itu proprietary Cisco — andalkan LLDP.)

### SNMP
```
snmp-agent community read cipher public
snmp-agent sys-info location "..."
snmp-agent target-host trap address udp-domain 192.168.1.100 params securityname public
```

### NetFlow / Traffic Monitoring (NetStream)
```
netstream export host 192.168.1.100
display interface | include rate
```

### Firewall Cepat Cek
```
display acl all
display nat session all
```

### Command "Sapu Jagat" Harian
```
display interface brief
display cpu-usage
display memory-usage
display ip routing-table statistics
display logbuffer
display lldp neighbor brief
```

---

## MIKROTIK ROUTEROS

### Navigasi Dasar
```
/                                     # root menu, tiap command pakai path
export                                # lihat config aktif
(otomatis tersimpan, tidak perlu command simpan manual)
/interface ethernet
/system reboot
/system resource print                # versi & hardware
```

### Interface & Status Fisik
```
/interface print
/interface ethernet print detail
/interface ethernet print stats
/ip address add address=192.168.1.1/24 interface=ether1
```

### CPU & Memory
```
/system resource print
/system health print
```

### Routing
```
/ip route print
/ip route print count-only
/routing bgp session print              # v7
/routing bgp peer print status           # v6
/routing bgp connection print detail     # v7
/routing ospf neighbor print
```

### Logging & History
```
/log print
/system logging action add name=remote target=remote remote=192.168.1.100
/system logging add topics=info action=remote
/log print where topics~"critical"
```

### Neighbor Discovery
```
/ip neighbor print                       # pakai MNDP/LLDP
```

### SNMP
```
/snmp set enabled=yes
/snmp set location="..." contact="..."
/snmp community add name=public
```

### NetFlow / Traffic Monitoring
```
/ip traffic-flow set enabled=yes
/ip traffic-flow target add address=192.168.1.100
/interface monitor-traffic ether1
```

### Firewall Cepat Cek
```
/ip firewall filter print
/ip firewall nat print
```

### Command "Sapu Jagat" Harian
```
/interface print
/system resource print
/ip route print count-only
/log print
/ip neighbor print
/routing bgp session print
```

---

## Catatan
- Cisco & Huawei syntax-nya beda tapi filosofi mirip (keduanya pakai `show`/`display` + keyword mirip).
- MikroTik jauh lebih berbeda karena berbasis path/menu (`/menu/sub-menu command`), bukan flat command seperti IOS/VRP.
- RouterOS v6 dan v7 punya perbedaan cukup besar khusus di bagian BGP dan routing filter — pastikan cek versi dulu sebelum apply command.
