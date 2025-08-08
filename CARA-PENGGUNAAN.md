# 📖 Cara Penggunaan AlrelShop VPN Server v2.0

## 🚀 Instalasi Cepat (Recommended)

### Method 1: One-Line Installation
```bash
bash <(curl -sL https://raw.githubusercontent.com/alrel1408/AlrelShop-VPN-v2/main/alrelshop-vpn-installer.sh)
```

### Method 2: Quick Setup
```bash
wget https://raw.githubusercontent.com/alrel1408/AlrelShop-VPN-v2/main/quick-setup.sh
chmod +x quick-setup.sh
./quick-setup.sh
```

## 📋 Langkah-Langkah Detail

### 1. Persiapan VPS/Server

#### Requirement Minimum:
- **OS**: Ubuntu 18/20/22/24/25 atau Debian 10/11/12
- **RAM**: 1GB (Recommended 2GB+)
- **Storage**: 10GB free space
- **Network**: Public IP address
- **Access**: Root privileges

#### Update System (WAJIB):
**Ubuntu:**
```bash
apt update && apt upgrade -y && update-grub && reboot
```

**Debian:**
```bash
apt update -y && apt upgrade -y && apt dist-upgrade -y && reboot
```

### 2. Download dan Jalankan Script

Setelah reboot, login sebagai root dan jalankan:

```bash
# Login sebagai root
sudo su -

# Install dependencies
apt update && apt install -y wget curl

# Download installer
wget https://raw.githubusercontent.com/alrel1408/AlrelShop-VPN-v2/main/alrelshop-vpn-installer.sh

# Beri permission
chmod +x alrelshop-vpn-installer.sh

# Jalankan installer
./alrelshop-vpn-installer.sh
```

### 3. Proses Instalasi

#### Step 1: System Check
Script akan otomatis check:
- ✅ OS compatibility
- ✅ Architecture (x86_64)
- ✅ Root access
- ✅ Network connectivity

#### Step 2: Confirmation
Anda akan melihat banner dan konfirmasi:
```
╔══════════════════════════════════════════════════════════════╗
║                 INSTALLATION CONFIRMATION                    ║
║  This installer will configure:                             ║
║  • Xray Core (Latest Version)                               ║
║  • Nginx Web Server                                         ║
║  • HAProxy Load Balancer                                    ║
║  • SSH/OpenVPN/Dropbear                                     ║
║  • WebSocket & gRPC Support                                 ║
║  • SSL Certificate (Let's Encrypt)                          ║
║  • User Management Panel                                    ║
╚══════════════════════════════════════════════════════════════╝

Do you want to continue with the installation?
[Y] Yes, continue installation
[N] No, cancel installation
```

Ketik **Y** untuk melanjutkan.

#### Step 3: Domain Configuration
Pilih tipe domain:
```
╔══════════════════════════════════════════════════════════════╗
║                    DOMAIN CONFIGURATION                      ║
║  [1] Use Custom Domain (Recommended)                        ║
║      • Better security and reliability                      ║
║      • Custom SSL certificate                               ║
║  [2] Use Random Subdomain                                   ║
║      • Quick setup for testing                              ║
╚══════════════════════════════════════════════════════════════╝
```

**Pilihan 1**: Masukkan domain Anda (contoh: vpn.domain-anda.com)
**Pilihan 2**: Script akan generate subdomain random

#### Step 4: Automatic Installation
Script akan install semua komponen secara otomatis (10-15 menit):
- System environment
- Web server (Nginx)
- Proxy server (HAProxy)
- VPN core (Xray)
- SSH services
- SSL certificates
- Management panel

#### Step 5: Completion
Setelah selesai, Anda akan melihat status semua service:
```
📊 SERVICE STATUS:
 ✓ nginx - Active
 ✓ xray - Active
 ✓ haproxy - Active
 ✓ dropbear - Active
 ✓ vnstat - Active
```

Server akan restart otomatis untuk menyelesaikan instalasi.

## 🎛️ Menggunakan Management Panel

### Akses Panel
Setelah server restart, login SSH dan ketik:
```bash
menu
```

### Menu Utama
```
╔══════════════════════════════════════════════════════════════╗
║                    ALRELSHOP VPN PANEL                      ║
║                   Professional Edition                      ║
╠══════════════════════════════════════════════════════════════╣
║  [1] Create Account                                          ║
║  [2] Delete Account                                          ║
║  [3] Extend Account                                          ║
║  [4] Check User Login                                        ║
║  [5] List All Users                                          ║
║  [6] Delete Expired Users                                    ║
║  [7] Set up Autokill                                         ║
║  [8] Cek Bandwith                                            ║
║  [9] Display Other Menu                                      ║
║  [x] Exit                                                    ║
╚══════════════════════════════════════════════════════════════╝
```

### Membuat Akun VPN

#### 1. VMess Account
```bash
# Di menu utama, pilih [1] Create Account
# Pilih protocol: VMess
# Masukkan username: contoh-user
# Masukkan durasi: 30 (untuk 30 hari)
```

#### 2. VLess Account  
```bash
# Pilih protocol: VLess
# Masukkan detail yang sama
```

#### 3. Trojan Account
```bash
# Pilih protocol: Trojan  
# Masukkan detail yang sama
```

#### 4. SSH Account
```bash
# Pilih protocol: SSH
# Masukkan username dan password
```

### Download Konfigurasi
Setelah membuat akun, Anda akan mendapat:
- **QR Code** untuk mobile apps
- **JSON Config** untuk desktop clients
- **Subscription URL** untuk auto-update

### Testing Koneksi
1. Download konfigurasi
2. Import ke VPN client (V2RayNG, V2RayN, dll)
3. Test koneksi

## 🔧 Management Commands

### Service Control
```bash
# Restart semua service
systemctl restart nginx xray haproxy

# Check status service
systemctl status xray

# View logs
journalctl -u xray -f
```

### User Management
```bash
# Lihat semua user aktif
menu -> [5] List All Users

# Delete user expired
menu -> [6] Delete Expired Users  

# Check user login
menu -> [4] Check User Login
```

### System Monitoring
```bash
# Bandwidth monitoring
menu -> [8] Cek Bandwith

# System resources
htop
vnstat

# Connection monitoring  
ss -tulpn
```

## 🛠️ Troubleshooting

### Jika Ada Masalah Service
```bash
# Auto-fix semua service
fix-services

# Fix specific issues
fix-ssh        # SSH issues
fix-speedtest  # Speedtest binary issues
```

### Manual Service Restart
```bash
# Restart individual services
systemctl restart nginx
systemctl restart xray
systemctl restart haproxy

# Check service logs
journalctl -u xray -n 50
tail -f /var/log/nginx/error.log
```

### Menu Command Not Found
```bash
# Fix PATH
export PATH="/usr/local/sbin:$PATH"

# Create symlink
ln -sf /usr/local/sbin/menu /usr/bin/menu

# Update bashrc
echo 'export PATH="/usr/local/sbin:$PATH"' >> ~/.bashrc
source ~/.bashrc
```

## 📱 Client Configuration

### Android (V2RayNG)
1. Install V2RayNG dari Play Store
2. Scan QR code dari server
3. Atau import config manual
4. Test koneksi

### Windows (V2RayN)
1. Download V2RayN dari GitHub
2. Import JSON config file  
3. Test koneksi

### iOS (Shadowrocket/Quantumult)
1. Install app dari App Store
2. Import via subscription URL
3. Test koneksi

### Router/OpenWrt
1. Install v2ray plugin
2. Import server config
3. Configure routing rules

## 🔄 Update System

### Update Script ke Versi Terbaru
```bash
wget https://raw.githubusercontent.com/alrel1408/AlrelShop-VPN-v2/main/update.sh
chmod +x update.sh
./update.sh
```

### Update Xray Core Manual
```bash
bash -c "$(curl -L https://github.com/XTLS/Xray-install/raw/main/install-release.sh)" @ install --version latest
systemctl restart xray
```

### Update Menu System
```bash
# Backup current menu
cp -r /usr/local/sbin /root/menu-backup

# Download update
wget -O menu.zip https://raw.githubusercontent.com/alrel1408/AlrelShop-VPN-v2/main/menu/menu.zip
unzip -o menu.zip
chmod +x menu/*
mv menu/* /usr/local/sbin/
rm -rf menu menu.zip
```

## 📊 Monitoring & Maintenance

### Daily Checks
```bash
# Service status
systemctl status nginx xray haproxy

# Resource usage
free -h
df -h

# Active connections
ss -tulpn | grep :443
```

### Weekly Maintenance
```bash
# Update system
apt update && apt upgrade -y

# Clean logs
/usr/local/sbin/clearlog

# Check expired users
menu -> [6] Delete Expired Users
```

### Monthly Tasks
```bash
# Full system update
apt update && apt upgrade -y && apt dist-upgrade -y

# Certificate renewal check
~/.acme.sh/acme.sh --list

# Backup configuration
tar -czf /root/backup-$(date +%Y%m%d).tar.gz /etc/xray /usr/local/sbin
```

## 🆘 Getting Help

### Built-in Help
```bash
# View documentation
cat /root/README.md

# Check troubleshooting
cat /root/TROUBLESHOOTING.md
```

### Contact Support
- **WhatsApp**: +6282285851668
- **Telegram**: @AlrelShop
- **Support Hours**: 09:00 - 22:00 WIB

### Information to Provide
Saat menghubungi support, sertakan:
1. OS dan versi server
2. Output dari: `systemctl status xray nginx haproxy`
3. Error message (jika ada)
4. Langkah yang sudah dicoba

---

## 🎯 Tips & Best Practices

### Security
1. **Change default SSH port** jika diperlukan
2. **Setup firewall** sesuai kebutuhan
3. **Regular updates** untuk security patches
4. **Monitor logs** untuk aktivitas mencurigakan

### Performance  
1. **Enable BBR** untuk TCP optimization
2. **Monitor bandwidth** usage
3. **Limit concurrent connections** sesuai server capacity
4. **Regular cleanup** logs dan temporary files

### Backup
1. **Backup configuration** secara berkala
2. **Document your settings** untuk recovery
3. **Test restore procedure** untuk memastikan backup works
4. **Store backup** di lokasi yang aman

**Happy VPN-ing with AlrelShop VPN Server v2.0! 🚀**
