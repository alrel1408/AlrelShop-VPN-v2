#!/bin/bash

# ======================================================
# AlrelShop VPN Quick Setup
# One-line installer for AlrelShop VPN Server v2.0
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
echo -e "${BLUE}║                ${GREEN}ALRELSHOP VPN QUICK SETUP${NC}${BLUE}                    ║${NC}"
echo -e "${BLUE}║                                                              ║${NC}"
echo -e "${BLUE}║    One-line installer untuk AlrelShop VPN Server v2.0       ║${NC}"
echo -e "${BLUE}║                                                              ║${NC}"
echo -e "${BLUE}╚══════════════════════════════════════════════════════════════╝${NC}"
echo ""

# Quick system check
if [ "$EUID" -ne 0 ]; then
    echo -e "${RED}Error: Script harus dijalankan sebagai root${NC}"
    echo -e "${YELLOW}Jalankan dengan: sudo bash quick-setup.sh${NC}"
    exit 1
fi

echo -e "${YELLOW}Memulai instalasi cepat...${NC}"
echo ""

# Update system dan install dependencies
echo -e "${BLUE}[1/3]${NC} ${YELLOW}Updating system...${NC}"
apt update >/dev/null 2>&1 && apt install -y wget curl >/dev/null 2>&1

# Download dan jalankan installer utama
echo -e "${BLUE}[2/3]${NC} ${YELLOW}Downloading installer...${NC}"
wget -O /tmp/alrelshop-installer.sh https://raw.githubusercontent.com/alrel1408/AlrelShop-VPN-v2/main/alrelshop-vpn-installer.sh >/dev/null 2>&1

if [ ! -f /tmp/alrelshop-installer.sh ]; then
    echo -e "${RED}Gagal mengunduh installer utama${NC}"
    exit 1
fi

chmod +x /tmp/alrelshop-installer.sh

# Jalankan installer utama
echo -e "${BLUE}[3/3]${NC} ${YELLOW}Starting main installation...${NC}"
echo ""
/tmp/alrelshop-installer.sh

# Cleanup
rm -f /tmp/alrelshop-installer.sh

echo ""
echo -e "${GREEN}Quick setup completed!${NC}"
