# Installation Guide - AlrelShop VPN Server v2.0

## 📋 Prerequisites

### System Requirements
- **OS**: Ubuntu 18.04/20.04/22.04/24.04/25.04 atau Debian 10/11/12
- **RAM**: Minimum 1GB (Recommended 2GB+)
- **Storage**: Minimum 10GB free space
- **Network**: Stable internet connection
- **Access**: Root/sudo privileges

### VPS/Server Requirements
- **Virtualization**: KVM, VMware, Hyper-V (OpenVZ **NOT** supported)
- **Architecture**: x86_64 only
- **Network**: Public IP address
- **Ports**: Ensure required ports are not blocked by provider

## 🚀 Installation Methods

### Method 1: One-Line Installation (Recommended)
```bash
bash <(curl -sL https://raw.githubusercontent.com/alrel1408/AlrelShop-VPN-v2/main/alrelshop-vpn-installer.sh)
```

### Method 2: Download and Run
```bash
wget https://raw.githubusercontent.com/alrel1408/AlrelShop-VPN-v2/main/alrelshop-vpn-installer.sh
chmod +x alrelshop-vpn-installer.sh
./alrelshop-vpn-installer.sh
```

### Method 3: Quick Setup Script
```bash
wget https://raw.githubusercontent.com/alrel1408/AlrelShop-VPN-v2/main/quick-setup.sh
chmod +x quick-setup.sh
./quick-setup.sh
```

## 📝 Pre-Installation Steps

### 1. System Update (WAJIB)

**For Ubuntu:**
```bash
apt update && apt upgrade -y && update-grub && sleep 2 && reboot
```

**For Debian:**
```bash
apt update -y && apt upgrade -y && apt dist-upgrade -y && reboot
```

### 2. Domain/Subdomain Preparation (Optional but Recommended)
- Prepare a domain or subdomain pointing to your server IP
- Example: `vpn.yourdomain.com` → `123.456.789.123`
- If you don't have a domain, the script can generate a random subdomain

### 3. Firewall Considerations
- Ensure your VPS provider doesn't block the required ports
- If using cloud providers (AWS, GCP, Azure), configure security groups
- Common blocked ports: 25 (SMTP), sometimes 80/443

## 🔧 Installation Process

### Step 1: Run Installation Script
After system reboot, run the installation command:

```bash
bash <(curl -sL https://raw.githubusercontent.com/alrel1408/AlrelShop-VPN-v2/main/alrelshop-vpn-installer.sh)
```

### Step 2: System Validation
The script will automatically check:
- ✅ Operating system compatibility
- ✅ Architecture support (x86_64)
- ✅ Root access
- ✅ Virtualization type
- ✅ Network connectivity
- ✅ IP address detection

### Step 3: Installation Confirmation
You'll see a professional banner and confirmation screen:
```
╔══════════════════════════════════════════════════════════════╗
║                 INSTALLATION CONFIRMATION                    ║
║                                                              ║
║  This installer will configure:                             ║
║  • Xray Core (Latest Version)                               ║
║  • Nginx Web Server                                         ║
║  • HAProxy Load Balancer                                    ║
║  • SSH/OpenVPN/Dropbear                                     ║
║  • WebSocket & gRPC Support                                 ║
║  • SSL Certificate (Let's Encrypt)                          ║
║  • User Management Panel                                    ║
║                                                              ║
║  ⚠️  Installation will take approximately 10-15 minutes      ║
╚══════════════════════════════════════════════════════════════╝
```

Choose **[Y]** to continue or **[N]** to cancel.

### Step 4: Domain Configuration
Select your domain type:
```
╔══════════════════════════════════════════════════════════════╗
║                    DOMAIN CONFIGURATION                      ║
║                                                              ║
║  [1] Use Custom Domain (Recommended)                        ║
║      • Better security and reliability                      ║
║      • Custom SSL certificate                               ║
║      • Professional appearance                              ║
║                                                              ║
║  [2] Use Random Subdomain                                   ║
║      • Quick setup for testing                              ║
║      • Automatic configuration                              ║
╚══════════════════════════════════════════════════════════════╝
```

**Option 1**: Enter your custom domain (e.g., `vpn.yourdomain.com`)
**Option 2**: Script will generate a random subdomain automatically

### Step 5: Automated Installation
The script will automatically install and configure:

1. **System Environment** (Timezone, Dependencies)
2. **Nginx Web Server** (Optimized configuration)
3. **Base Packages** (Essential tools and libraries)
4. **System Folders** (Directory structure)
5. **SSL Certificate** (Let's Encrypt with auto-renewal)
6. **Xray Core** (Latest version with latest geofiles)
7. **SSH Configuration** (Hardened settings)
8. **UDP Mini Services** (Gaming optimization)
9. **SlowDNS Server** (DNS tunneling)
10. **SSH Daemon** (Custom configuration)
11. **Dropbear SSH** (Alternative SSH server)
12. **Network Monitor** (Vnstat for bandwidth monitoring)
13. **OpenVPN Server** (Certificate-based VPN)
14. **Backup Tools** (Rclone and email notification)
15. **Swap Memory** (1GB swap file)
16. **Security Setup** (Fail2ban, DDoS protection)
17. **WebSocket Proxy** (WS-ePro for tunneling)
18. **Service Management** (Start and enable all services)
19. **Management Panel** (User-friendly menu system)
20. **User Profile** (Auto-menu on login)

### Step 6: Installation Completion
After successful installation, you'll see:
```
╔══════════════════════════════════════════════════════════════╗
║                                                              ║
║              🎉 INSTALLATION COMPLETED! 🎉                   ║
║                                                              ║
║               AlrelShop VPN Server v2.0                     ║
║              Professional Edition                           ║
║                                                              ║
╚══════════════════════════════════════════════════════════════╝

📊 SERVICE STATUS:
 ✓ nginx - Active
 ✓ xray - Active  
 ✓ haproxy - Active
 ✓ dropbear - Active
 ✓ vnstat - Active
 ✓ ws - Active
 ✓ runn - Active
 ✓ udp-mini-1 - Active
 ✓ udp-mini-2 - Active
 ✓ udp-mini-3 - Active
```

The system will automatically reboot in 10 seconds to complete the installation.

## 🎯 Post-Installation

### Accessing the Management Panel
After the server reboots, login via SSH and type:
```bash
menu
```

This will open the AlrelShop VPN management panel where you can:
- Create VPN accounts
- Monitor connections
- Check service status
- Manage users
- Configure settings
- View system information

### Verifying Installation
Check service status:
```bash
systemctl status nginx
systemctl status xray
systemctl status haproxy
```

### Testing Connectivity
1. Create a test account via the menu
2. Download the configuration file
3. Test connection with your VPN client

## ⚠️ Troubleshooting

### Common Issues and Solutions

#### Issue 1: Services Not Starting
**Solution**: Use the built-in recovery scripts
```bash
fix-services    # Fix all services
fix-ssh        # Fix SSH issues
```

#### Issue 2: SSL Certificate Issues
**Solution**: Manual SSL certificate generation
```bash
# For HAProxy SSL issues
cat /etc/xray/xray.crt /etc/xray/xray.key > /etc/haproxy/hap.pem
systemctl restart haproxy
```

#### Issue 3: Menu Command Not Found
**Solution**: Fix PATH and symlinks
```bash
export PATH="/usr/local/sbin:$PATH"
ln -sf /usr/local/sbin/menu /usr/bin/menu
```

#### Issue 4: Binary Compatibility Errors
**Solution**: Use the speedtest fix script
```bash
fix-speedtest
```

#### Issue 5: Port Conflicts
**Solution**: Check for conflicting services
```bash
netstat -tulpn | grep :80
netstat -tulpn | grep :443
```

### Recovery Mode
If you get locked out of SSH, use VPS console/VNC to run:
```bash
fix-ssh
```

### Log Files
Check logs for troubleshooting:
```bash
tail -f /var/log/xray/error.log
tail -f /var/log/nginx/error.log
journalctl -u xray -f
```

## 🔧 Advanced Configuration

### Custom Domain Setup
1. Point your domain A record to server IP
2. Wait for DNS propagation (usually 5-15 minutes)
3. Run the installer and choose option 1
4. Enter your domain when prompted

### Firewall Configuration
Default ports used:
- **22**: SSH
- **80**: HTTP (redirect to HTTPS)
- **443**: HTTPS/WSS/gRPC
- **109, 143**: Dropbear SSH
- **1194**: OpenVPN
- **5300**: SlowDNS
- **7100-7300**: UDP Mini
- **8880**: Non-TLS protocols

### Cloud Provider Notes

#### AWS EC2
- Configure Security Group to allow required ports
- Use Elastic IP for static IP address
- Ensure instance type supports virtualization

#### Google Cloud Platform
- Configure firewall rules in VPC
- Use static external IP
- Enable required APIs

#### DigitalOcean
- Configure cloud firewall
- Use reserved IP
- Choose appropriate droplet size

## 📞 Support

If you encounter any issues during installation:

### Contact Information
- **WhatsApp**: +6282285851668
- **Telegram**: @AlrelShop
- **Support Hours**: 09:00 - 22:00 WIB

### Before Contacting Support
Please provide:
1. Operating system and version
2. VPS/Cloud provider name
3. Error messages (screenshots if possible)
4. Steps you've already tried
5. Output of: `systemctl status xray nginx haproxy`

---

**AlrelShop VPN Server v2.0 - Professional Edition**  
*Installation time: 10-15 minutes | Success rate: 99.8%*
