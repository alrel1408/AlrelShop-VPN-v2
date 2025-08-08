# Troubleshooting Guide - AlrelShop VPN Server v2.0

## 🔧 Common Issues and Solutions

### 1. Installation Issues

#### Error: "Permission Denied" during installation
**Cause**: Not running as root or sudo
**Solution**:
```bash
sudo su -
# Then run the installation script again
```

#### Error: "Operating System not supported"
**Cause**: Running on unsupported OS version
**Solution**: 
- Use supported OS: Ubuntu 18.04/20.04/22.04/24.04/25.04 or Debian 10/11/12
- Check your OS version: `cat /etc/os-release`

#### Error: "OpenVZ is not supported"
**Cause**: VPS using OpenVZ virtualization
**Solution**: 
- Use KVM/VMware/Hyper-V based VPS instead
- OpenVZ doesn't support required kernel features

#### Error: "Architecture not supported"
**Cause**: Running on non-x86_64 architecture
**Solution**: 
- Use x86_64 (amd64) server
- ARM architectures are not supported

### 2. Service Issues

#### Services not starting after installation
**Symptom**: `systemctl status service` shows failed state
**Solution**:
```bash
# Use built-in recovery script
fix-services

# Or manually restart services
systemctl daemon-reload
systemctl restart nginx xray haproxy
```

#### Xray service failed to start
**Symptom**: `systemctl status xray` shows failed
**Solution**:
```bash
# Check configuration
xray test -c /etc/xray/config.json

# Check logs
journalctl -u xray -n 50

# Restart with proper permissions
systemctl restart xray
```

#### HAProxy SSL certificate error
**Symptom**: HAProxy fails to start with SSL error
**Solution**:
```bash
# Recreate SSL certificate for HAProxy
cat /etc/xray/xray.crt /etc/xray/xray.key > /etc/haproxy/hap.pem
chmod 600 /etc/haproxy/hap.pem
systemctl restart haproxy
```

#### Nginx configuration test failed
**Symptom**: `nginx -t` returns errors
**Solution**:
```bash
# Check nginx configuration
nginx -t

# Fix common issues
sed -i 's/xxx/your-domain.com/g' /etc/nginx/conf.d/xray.conf

# Restart nginx
systemctl restart nginx
```

### 3. Connection Issues

#### Cannot connect to VPN
**Possible Causes & Solutions**:

1. **Firewall blocking ports**
   ```bash
   # Check if ports are open
   netstat -tulpn | grep :443
   netstat -tulpn | grep :80
   
   # Open required ports
   iptables -I INPUT -p tcp --dport 443 -j ACCEPT
   iptables -I INPUT -p tcp --dport 80 -j ACCEPT
   iptables-save > /etc/iptables.up.rules
   ```

2. **Services not running**
   ```bash
   # Check service status
   systemctl status nginx xray haproxy
   
   # Start services if stopped
   systemctl start nginx xray haproxy
   ```

3. **Domain/SSL issues**
   ```bash
   # Check SSL certificate
   openssl x509 -in /etc/xray/xray.crt -text -noout
   
   # Renew SSL if expired
   ~/.acme.sh/acme.sh --renew -d yourdomain.com --force
   ```

#### Slow connection or high latency
**Solutions**:
```bash
# Enable BBR (if not already enabled)
echo 'net.core.default_qdisc=fq' >> /etc/sysctl.conf
echo 'net.ipv4.tcp_congestion_control=bbr' >> /etc/sysctl.conf
sysctl -p

# Check UDP Mini services
systemctl status udp-mini-1 udp-mini-2 udp-mini-3

# Restart UDP services
systemctl restart udp-mini-1 udp-mini-2 udp-mini-3
```

### 4. Menu and Command Issues

#### "menu" command not found
**Solution**:
```bash
# Fix PATH environment
export PATH="/usr/local/sbin:$PATH"

# Create symlinks
ln -sf /usr/local/sbin/menu /usr/bin/menu
ln -sf /usr/local/sbin/menu /bin/menu

# Update bashrc
echo 'export PATH="/usr/local/sbin:$PATH"' >> ~/.bashrc
source ~/.bashrc
```

#### Menu shows but gives "Permission Denied" errors
**Solution**:
```bash
# Fix file permissions
chmod +x /usr/local/sbin/menu
chmod +x /usr/local/sbin/*

# The v2.0 has registration system disabled, so this shouldn't happen
# If it does, check file ownership
chown root:root /usr/local/sbin/*
```

### 5. Binary Compatibility Issues

#### "exec format error" on speedtest
**Solution**:
```bash
# Use the built-in fix script
fix-speedtest

# Or manually install speedtest-cli
apt update && apt install -y speedtest-cli
```

#### UDP Mini services not starting
**Solution**:
```bash
# Check binary
file /usr/local/alrelshop/udp-mini

# If binary is corrupt, the script has fallback
systemctl restart udp-mini-1 udp-mini-2 udp-mini-3

# Check logs
journalctl -u udp-mini-1 -n 20
```

#### WebSocket proxy not working
**Solution**:
```bash
# Check WS-ePro service
systemctl status ws

# Restart WS service
systemctl restart ws

# Check binary compatibility
file /usr/bin/ws

# Check configuration
cat /usr/bin/tun.conf
```

### 6. SSH Access Issues

#### Cannot SSH after installation
**Symptom**: SSH connection refused or times out
**Solution using VPS Console/VNC**:
```bash
# Use the recovery script
fix-ssh

# Or manually fix SSH
systemctl start ssh
systemctl enable ssh

# Check SSH configuration
sshd -t

# Reset SSH to safe configuration if needed
cat > /etc/ssh/sshd_config << 'EOF'
Port 22
PermitRootLogin yes
PasswordAuthentication yes
PubkeyAuthentication yes
UsePAM yes
X11Forwarding yes
PrintMotd no
AcceptEnv LANG LC_*
Subsystem sftp /usr/lib/openssh/sftp-server
EOF

systemctl restart ssh
```

#### SSH works but Dropbear doesn't
**Solution**:
```bash
# Check Dropbear status
service dropbear status

# Restart Dropbear
service dropbear restart

# Check configuration
cat /etc/default/dropbear

# Regenerate keys if needed
dropbearkey -t rsa -f /etc/dropbear/dropbear_rsa_host_key -s 2048
service dropbear restart
```

### 7. Performance Issues

#### High CPU usage
**Diagnosis & Solution**:
```bash
# Check top processes
top
htop

# Check specific services
systemctl status xray nginx haproxy

# Restart problematic services
systemctl restart xray

# Check for resource limits
ulimit -a
```

#### High memory usage
**Solution**:
```bash
# Check memory usage
free -h

# Check swap
swapon -s

# Clear cache if needed
sync && echo 3 > /proc/sys/vm/drop_caches

# Restart memory-heavy services
systemctl restart xray nginx
```

#### Disk space issues
**Solution**:
```bash
# Check disk usage
df -h

# Clean logs
/usr/local/sbin/clearlog

# Clean package cache
apt clean
apt autoremove

# Check large files
du -sh /var/log/*
```

### 8. SSL Certificate Issues

#### SSL certificate expired
**Solution**:
```bash
# Check certificate expiry
openssl x509 -in /etc/xray/xray.crt -enddate -noout

# Renew certificate
~/.acme.sh/acme.sh --renew -d yourdomain.com --force

# Update HAProxy certificate
cat /etc/xray/xray.crt /etc/xray/xray.key > /etc/haproxy/hap.pem
chmod 600 /etc/haproxy/hap.pem

# Restart services
systemctl restart haproxy nginx
```

#### ACME challenge failed
**Solution**:
```bash
# Stop web services temporarily
systemctl stop nginx

# Try standalone mode
~/.acme.sh/acme.sh --issue -d yourdomain.com --standalone

# Start services again
systemctl start nginx
```

### 9. Network and Connectivity

#### Domain not resolving
**Solution**:
```bash
# Check DNS resolution
nslookup yourdomain.com
dig yourdomain.com

# Check if domain points to correct IP
curl -I http://yourdomain.com

# Update domain in configuration if needed
echo "yourdomain.com" > /etc/xray/domain
```

#### Cloudflare SSL issues
**Solution**:
- Set Cloudflare SSL to "Full" mode
- Disable "Always Use HTTPS" temporarily during setup
- Enable "WebSocket" and "gRPC" in Cloudflare Network settings

### 10. User Management Issues

#### Cannot create users
**Solution**:
```bash
# Check database files
ls -la /etc/vmess/ /etc/vless/ /etc/trojan/

# Fix permissions
chmod 644 /etc/vmess/.vmess.db
chmod 644 /etc/vless/.vless.db  
chmod 644 /etc/trojan/.trojan.db

# Create files if missing
touch /etc/vmess/.vmess.db
echo "# AlrelShop VPN Account Database" > /etc/vmess/.vmess.db
```

#### User accounts not working
**Solution**:
```bash
# Check Xray configuration
xray test -c /etc/xray/config.json

# Restart Xray service
systemctl restart xray

# Check user configuration in menu
menu
```

## 🛠️ Diagnostic Commands

### System Information
```bash
# OS information
cat /etc/os-release
uname -a

# Resource usage
free -h
df -h
top

# Network information
ip addr show
netstat -tulpn
```

### Service Status
```bash
# Check all main services
systemctl status nginx xray haproxy dropbear vnstat

# Check custom services
systemctl status ws runn udp-mini-1 udp-mini-2 udp-mini-3

# Check logs
journalctl -u xray -f
journalctl -u nginx -f
```

### Network Testing
```bash
# Test local ports
curl -I http://localhost
curl -I https://localhost

# Test external connectivity
curl -I http://yourdomain.com
curl -I https://yourdomain.com

# Check SSL certificate
openssl s_client -connect yourdomain.com:443
```

## 📞 Getting Help

### Before Contacting Support

1. **Check this troubleshooting guide** first
2. **Try the built-in recovery scripts**:
   ```bash
   fix-services
   fix-ssh
   fix-speedtest
   ```
3. **Gather diagnostic information**:
   ```bash
   # System info
   cat /etc/os-release
   
   # Service status
   systemctl status nginx xray haproxy
   
   # Error logs
   journalctl -u xray -n 50
   tail -f /var/log/nginx/error.log
   ```

### Contact Information
- **WhatsApp**: +6282285851668
- **Telegram**: @AlrelShop
- **Support Hours**: 09:00 - 22:00 WIB

### Information to Provide
When contacting support, please include:
1. **Operating system** and version
2. **VPS/Cloud provider** name
3. **Error messages** (exact text or screenshots)
4. **Steps you've already tried**
5. **Output of diagnostic commands**
6. **Whether this is a fresh installation** or an update

## 🔄 Recovery Procedures

### Complete Service Reset
```bash
# Stop all services
systemctl stop nginx xray haproxy ws runn
systemctl stop udp-mini-1 udp-mini-2 udp-mini-3

# Reload daemon
systemctl daemon-reload

# Start services in order
systemctl start nginx
systemctl start haproxy  
systemctl start xray
systemctl start ws runn
systemctl start udp-mini-1 udp-mini-2 udp-mini-3
```

### Nuclear Option: Reinstall
If all else fails:
```bash
# Backup important data
cp -r /etc/xray /root/backup-$(date +%Y%m%d)

# Download and run installer again
wget https://raw.githubusercontent.com/alrel1408/AlrelShop-VPN-v2/main/alrelshop-vpn-installer.sh
chmod +x alrelshop-vpn-installer.sh
./alrelshop-vpn-installer.sh
```

---

**Remember**: AlrelShop VPN v2.0 includes built-in recovery scripts and better error handling. Most issues can be resolved automatically using the `fix-*` commands.
