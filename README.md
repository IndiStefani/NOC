# 📡 Network Command Cheatsheet

Kumpulan command yang sering dipakai untuk operasional OLT GPON, Mikrotik, dan Switch (Cisco/Huawei).

## Daftar Isi

- [OLT GPON](#olt-gpon)
- [Mikrotik](#mikrotik)
- [Switch Cisco / Huawei](#switch-cisco--huawei)
- [Troubleshooting: Internet Down](#-troubleshooting-internet-down)

---

## OLT GPON

| Fungsi | Command |
|---|---|
| Menampilkan VLAN di GPON | `show gpon profile tcont` |
| Melihat informasi kartu SFP | `show card` |
| Melihat system group | `show system-group` |
| Menampilkan informasi jam | `show clock` |
| Restart 1 card PON | `reset-card <slotno>` |
| Melihat status perangkat ONU | `show running interface gpon-onu_1/1/12:17` |
| Melihat status pon di olt | `show interface gpon-olt_1/2/12` |

---

## Switch Cisco / Huawei
 
> ⚠️ Catatan: `show` = sintaks Cisco, `display` = sintaks Huawei. Sesuaikan dengan vendor perangkat.
 
### Interface
 
| Fungsi | Command |
|---|---|
| Detail konfigurasi interface (Cisco) | `show interface ethernet 1/40` |
| Cek switchport interface (Cisco) | `show interface eth1/40 switchport` |
| Detail status & statistik interface (Huawei) | `display interface XGigabitEthernet 0/0/37` / `display interface gi 0/0/4` |
| Ringkasan semua interface (Huawei) | `display interface brief` |
| Ringkasan IP interface (Huawei) | `display ip interface brief` |
| Detail status receiver/optik pada interface (Cisco) | `show interface ethernet 1/40 transceiver details` |
 
### Routing
 
| Fungsi | Command |
|---|---|
| Melihat status route ke suatu IP | `show route <ip_tujuan>` <br> contoh: `show route 18.168.116.121` |
| Melihat detail routing untuk suatu IP | `show route <ip_tujuan>` <br> contoh: `show route 45.115.65.193` |
 
### BGP
 
| Fungsi | Command |
|---|---|
| Melihat routing BGP untuk IP tujuan | `show bgp summary \| match <ip_tujuan>` |
| Melihat sesi BGP dengan neighbor tertentu | `show bgp summary \| match 175.184.239.189` |
| Detail satu neighbor BGP | `show bgp neighbor 175.184.239.189` |
| Routing yang diadvertise ke neighbor BGP | `show route advertising-protocol bgp 175.184.239.189` |
 
### VLAN
 
| Fungsi | Command |
|---|---|
| Melihat daftar VLAN (Cisco) | `show vlan brief` |
| Melihat konfigurasi VLAN (Huawei) | `display vlan` |
| Melihat VLAN pada satu interface (Cisco) | `show interface ethernet 1/40 switchport` |
 
### MAC Address & ARP
 
| Fungsi | Command |
|---|---|
| Melihat MAC address table (Cisco) | `show mac address-table` |
| Melihat MAC address table (Huawei) | `display mac-address` |
| Melihat ARP table (Cisco) | `show arp` |
| Melihat ARP table (Huawei) | `display arp` |
 
### Ping / Traceroute / VPN Instance
 
```
ping -vpn-instance underlay_(1/2) 8.8.8.8
```
 
| Fungsi | Command |
|---|---|
| Ping standar (Cisco) | `ping <ip_tujuan>` |
| Traceroute (Cisco) | `traceroute <ip_tujuan>` |
| Traceroute (Huawei) | `tracert <ip_tujuan>` |
 
### System & Log
 
| Fungsi | Command |
|---|---|
| Melihat versi software (Cisco) | `show version` |
| Melihat versi software (Huawei) | `display version` |
| Melihat konfigurasi berjalan (Cisco) | `show running-config` |
| Melihat konfigurasi berjalan (Huawei) | `display current-configuration` |
| Melihat log sistem (Cisco) | `show logging` |
| Melihat log sistem (Huawei) | `display logbuffer` |
| Melihat penggunaan CPU (Huawei) | `display cpu-usage` |
| Melihat penggunaan memory (Huawei) | `display memory-usage` |

---

## 🔧 Troubleshooting: Internet Down

Urutan pengecekan standar saat ada laporan **"internet down"**:

1. **Cek status interface**
   `display interface` / `show interfaces`
2. **Cek IP interface** — pastikan konfigurasi IP masih benar
   `display ip interface brief` / `show ip interface brief`
3. **Ping gateway atau next-hop**
4. **Cek routing table**
   `display ip routing-table` / `show ip route`
   Jika pakai BGP, cek sesi BGP: `display bgp peer` / `show bgp summary`
5. **Traceroute** — untuk melihat jalur paket
6. **Cek log**
   `display logbuffer` / `show logging`
7. **Jika pakai fiber, cek kondisi optik**
   `display transceiver` / `show interfaces transceiver detail`