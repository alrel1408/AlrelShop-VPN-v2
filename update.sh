#!/bin/bash

# ======================================================
# AlrelShop VPN Update Script
# Script untuk update AlrelShop VPN ke versi terbaru
# ======================================================

# Colors
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
BLUE='\033[0;36m'
NC='\033[0m'

clear

echo -e "${BLUE}╔══════════════════════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║                                                              ║${NC}"
echo -e "${BLUE}║                ${GREEN}ALRELSHOP VPN UPDATER${NC}${BLUE}                       ║${NC}"
echo -e "${BLUE}║                  ${YELLOW}Professional Edition${NC}${BLUE}                     ║${NC}"
echo -e "${BLUE}║                                                              ║${NC}"
echo -e "${BLUE}╚══════════════════════════════════════════════════════════════╝${NC}"
echo ""

# Check root access
if [ "$EUID" -ne 0 ]; then
    echo -e "${RED}Error: Script harus dijalankan sebagai root${NC}"
    echo -e "${YELLOW}Jalankan dengan: sudo bash update.sh${NC}"
    exit 1
fi

# Get current version
CURRENT_VERSION="Unknown"
if [ -f /etc/alrelshop/version ]; then
    CURRENT_VERSION=$(cat /etc/alrelshop/version)
fi

echo -e "${BLUE}Current Version:${NC} ${YELLOW}$CURRENT_VERSION${NC}"
echo -e "${BLUE}Latest Version:${NC} ${GREEN}2.0 Professional Edition${NC}"
echo ""

# Check if update is needed
echo -e "${YELLOW}Checking for updates...${NC}"

# Create backup
echo -e "${YELLOW}Creating backup of current configuration...${NC}"
mkdir -p /root/alrelshop-backup-$(date +%Y%m%d_%H%M%S)
cp -r /etc/xray /root/alrelshop-backup-$(date +%Y%m%d_%H%M%S)/ 2>/dev/null || true
cp -r /usr/local/sbin /root/alrelshop-backup-$(date +%Y%m%d_%H%M%S)/ 2>/dev/null || true

echo -e "${GREEN}✓ Backup created${NC}"

# Download update script
echo -e "${YELLOW}Downloading update components...${NC}"

# Update menu system
wget -O menu.zip https://raw.githubusercontent.com/alrel1408/AlrelShop-VPN-v2/main/menu/menu.zip >/dev/null 2>&1
if [ -f menu.zip ]; then
    unzip -o menu.zip >/dev/null 2>&1
    chmod +x menu/*
    mv menu/* /usr/local/sbin/
    rm -rf menu menu.zip
    echo -e "${GREEN}✓ Menu system updated${NC}"
fi

# Update Xray Core
echo -e "${YELLOW}Updating Xray Core...${NC}"
latest_version="$(curl -s https://api.github.com/repos/XTLS/Xray-core/releases | grep tag_name | sed -E 's/.*"v(.*)".*/\1/' | head -n 1)"
bash -c "$(curl -L https://github.com/XTLS/Xray-install/raw/main/install-release.sh)" @ install -u www-data --version $latest_version >/dev/null 2>&1
echo -e "${GREEN}✓ Xray Core updated to v$latest_version${NC}"

# Update geo data
echo -e "${YELLOW}Updating geo data files...${NC}"
wget -q -O /usr/local/share/xray/geosite.dat "https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geosite.dat" >/dev/null 2>&1
wget -q -O /usr/local/share/xray/geoip.dat "https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geoip.dat" >/dev/null 2>&1
echo -e "${GREEN}✓ Geo data updated${NC}"

# Update version info
mkdir -p /etc/alrelshop
echo "2.0-Professional" > /etc/alrelshop/version
echo "$(date)" > /etc/alrelshop/last_update

# Restart services
echo -e "${YELLOW}Restarting services...${NC}"
systemctl daemon-reload
systemctl restart xray >/dev/null 2>&1
systemctl restart nginx >/dev/null 2>&1
systemctl restart haproxy >/dev/null 2>&1

echo ""
echo -e "${GREEN}╔══════════════════════════════════════════════════════════════╗${NC}"
echo -e "${GREEN}║                                                              ║${NC}"
echo -e "${GREEN}║                    ✅ UPDATE COMPLETED!                       ║${NC}"
echo -e "${GREEN}║                                                              ║${NC}"
echo -e "${GREEN}║              AlrelShop VPN v2.0 Professional                ║${NC}"
echo -e "${GREEN}║                                                              ║${NC}"
echo -e "${GREEN}║  All components have been updated to the latest version     ║${NC}"
echo -e "${GREEN}║                                                              ║${NC}"
echo -e "${GREEN}║  Type 'menu' to access the management panel                 ║${NC}"
echo -e "${GREEN}║                                                              ║${NC}"
echo -e "${GREEN}╚══════════════════════════════════════════════════════════════╝${NC}"
echo ""
echo -e "${BLUE}Support: ${GREEN}+6282285851668 (WhatsApp)${NC}"
echo -e "${BLUE}Telegram: ${GREEN}@AlrelShop${NC}"
echo ""
