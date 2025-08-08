# AlrelShop VPN Auto-Script v2.0
## Professional Edition

<p align="center">
<img src="https://readme-typing-svg.herokuapp.com?color=%2336BCF7&center=true&vCenter=true&lines=A+L+R+E+L+S+H+O+P++V+P+N++S+E+R+V+E+R;P+R+O+F+E+S+S+I+O+N+A+L++E+D+I+T+I+O+N" />
</p>

## 🌟 Tentang Script Ini

Script VPN otomatis premium yang dikembangkan oleh **AlrelShop Team** dengan fitur-fitur canggih dan keamanan tingkat enterprise. Version 2.0 ini telah diperbaiki dari berbagai bug dan error yang ada di versi sebelumnya.

## ✨ Fitur Unggulan

### 🔧 Multi-Protocol Support
- **Xray Core** (Latest Version dengan auto-update)
- **VMess** (WebSocket & gRPC)
- **VLess** (WebSocket & gRPC + Non-TLS)
- **Trojan** (WebSocket & gRPC)
- **Shadowsocks** (WebSocket & gRPC)
- **SSH/OpenVPN/Dropbear** dengan SlowDNS
- **WebSocket Proxy** (WS-ePro)

### 🛡️ Keamanan & Performance
- **SSL/TLS** Certificate otomatis (Let's Encrypt)
- **HAProxy** Load Balancer dengan SSL termination
- **Nginx** Web Server dengan optimasi
- **Anti-Torrent** protection
- **DDoS** protection basic
- **BBR TCP** congestion control
- **UDP Mini** untuk gaming dan low-latency

### 👥 Management System
- **User Management** Panel lengkap
- **Auto Delete** Expired accounts
- **Multi-Login** limit control
- **Bandwidth** monitoring dengan vnstat
- **Real-time** connection monitoring
- **Backup & Restore** system
- **Auto Reboot** scheduler

### 📱 Integration Features
- **Telegram Bot** integration (opsional)
- **WhatsApp** support contact
- **Email** notification system
- **Auto SSL** renewal

## 🖥️ Sistem Operasi yang Didukung

### Ubuntu (Fully Tested)
- ✅ Ubuntu 18.04 LTS (Bionic Beaver)
- ✅ Ubuntu 20.04 LTS (Focal Fossa) 
- ✅ Ubuntu 22.04 LTS (Jammy Jellyfish)
- ✅ Ubuntu 24.04 LTS (Noble Numbat)
- ✅ Ubuntu 25.04 (Oracular Oriole)

### Debian (Fully Tested)  
- ✅ Debian 10 (Buster)
- ✅ Debian 11 (Bullseye)
- ✅ Debian 12 (Bookworm)

## 🚀 Instalasi

### Persiapan Sistem (WAJIB)

**Untuk Ubuntu:**
```bash
apt update && apt upgrade -y && update-grub && sleep 2 && reboot
```

**Untuk Debian:**
```bash
apt update -y && apt upgrade -y && apt dist-upgrade -y && reboot
```

### Instalasi Script

Setelah reboot, jalankan command berikut:

```bash
apt install -y wget curl && wget -O alrelshop-installer.sh https://raw.githubusercontent.com/alrel1408/AlrelShop-VPN-v2/main/alrelshop-vpn-installer.sh && chmod +x alrelshop-installer.sh && ./alrelshop-installer.sh
```

### Quick Install (One-Liner)
```bash
bash <(curl -sL https://raw.githubusercontent.com/alrel1408/AlrelShop-VPN-v2/main/alrelshop-vpn-installer.sh)
```

## 🔧 Perbaikan dari Versi Sebelumnya

### ✅ Issues Fixed:
1. **Banner Profesional** - Tidak ada lagi kata-kata tidak pantas
2. **Sistem Registrasi** - Dinonaktifkan untuk menghindari error "Permission Denied"
3. **Konfirmasi Reboot** - Sistem konfirmasi yang lebih jelas dan user-friendly
4. **Binary Compatibility** - Fixed error "exec format error" pada berbagai binary
5. **Service Dependencies** - Perbaikan urutan start service untuk menghindari conflict
6. **SSL Certificate** - Auto-generation dan fallback certificate
7. **HAProxy Configuration** - Fixed SSL certificate integration
8. **Error Handling** - Better error handling dan recovery system
9. **Path Management** - Fixed menu command availability
10. **Branding Update** - Semua referensi diupdate ke AlrelShop

### 🆕 New Features:
- Professional banner design
- Better installation confirmation system
- Auto-troubleshooting untuk service yang bermasalah
- Recovery scripts untuk SSH dan service issues
- Improved progress indicators
- Better service status monitoring
- Enhanced error reporting

## 📋 Port Information

```
🔐 SSL/TLS Protocols:
- TROJAN WebSocket: 443
- TROJAN gRPC: 443  
- SHADOWSOCKS WebSocket: 443
- SHADOWSOCKS gRPC: 443
- VLESS WebSocket: 443
- VLESS gRPC: 443
- VMESS WebSocket: 443
- VMESS gRPC: 443
- SSH WebSocket/TLS: 443

🌐 Non-TLS Protocols:
- VLESS Non-TLS: 80
- VMESS Non-TLS: 80
- SSH Non-TLS: 8880, 80

🔑 SSH Services:
- SSH Standard: 22
- Dropbear: 109, 143
- SSH UDP: 1-65535

🌍 VPN Services:
- OpenVPN SSL/TCP: 1194
- SlowDNS: 5300

🎮 Gaming Optimization:
- UDP Mini 1: 7100
- UDP Mini 2: 7200  
- UDP Mini 3: 7300
```

## ⚙️ Cloudflare Settings (Recommended)

```
SSL/TLS: FULL
SSL/TLS Recommender: OFF
gRPC: ON
WebSocket: ON
Always Use HTTPS: OFF
Under Attack Mode: OFF
```

## 🎯 Post-Installation

### Mengakses Panel Management
Setelah instalasi selesai dan server reboot, ketik:
```bash
menu
```

### Service Status Check
```bash
systemctl status nginx
systemctl status xray
systemctl status haproxy
```

### Troubleshooting Scripts
Jika ada masalah, gunakan script recovery yang tersedia:
```bash
fix-services    # Memperbaiki service yang bermasalah
fix-ssh        # Recovery SSH access  
fix-speedtest  # Memperbaiki speedtest binary
```

## 🆘 Support & Contact

### 📞 Contact Information
- **WhatsApp**: +6282285851668
- **Telegram**: @AlrelShop
- **Support Hours**: 09:00 - 22:00 WIB

### 🌐 Links
- **Official Website**: Coming Soon
- **Documentation**: Coming Soon
- **Video Tutorial**: Coming Soon

## ⚠️ Important Notes

1. **Root Access Required** - Script harus dijalankan sebagai root user
2. **Fresh Installation** - Recommended untuk VPS/server yang fresh install
3. **Backup Data** - Backup data penting sebelum instalasi
4. **Internet Connection** - Pastikan koneksi internet stabil selama instalasi
5. **Domain/Subdomain** - Siapkan domain/subdomain yang sudah pointing ke IP server
6. **Port Requirements** - Pastikan port yang diperlukan tidak diblock oleh provider

## 📝 Changelog

### Version 2.0 (Current)
- Complete rewrite dengan better error handling
- Professional branding dan banner
- Fixed binary compatibility issues  
- Improved service management
- Enhanced security features
- Better user experience
- Auto-recovery scripts

### Version 1.x (Previous)
- Basic functionality
- Multiple compatibility issues
- Registration system dependency
- Limited error handling

## 📄 License

Copyright © 2024 AlrelShop Solutions. All rights reserved.

Script ini dikembangkan khusus untuk kebutuhan VPN server profesional. Dilarang untuk didistribusikan ulang atau dimodifikasi tanpa izin dari AlrelShop Team.

## 🙏 Credits

Terima kasih kepada:
- XTLS Team untuk Xray Core
- Let's Encrypt untuk SSL certificates
- Semua developer tools dan libraries yang digunakan
- Community yang telah memberikan feedback

---

**AlrelShop VPN Server v2.0 - Professional Edition**
*Developed with ❤️ by AlrelShop Team*
