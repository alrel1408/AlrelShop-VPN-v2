#!/bin/bash

# ======================================================
# AlrelShop VPN Quick Installer
# Created by: AlrelShop Team  
# Version: 2.0 Professional Edition
# Support: Ubuntu 18,20,22,24,25 & Debian 10,11,12
# ======================================================

# Colors
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
BLUE='\033[0;36m'
NC='\033[0m'

clear

# Professional Banner
echo -e "${BLUE}╔══════════════════════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║                                                              ║${NC}"
echo -e "${BLUE}║               ${GREEN}ALRELSHOP VPN QUICK INSTALLER${NC}${BLUE}                ║${NC}"
echo -e "${BLUE}║                 ${YELLOW}Professional Edition v2.0${NC}${BLUE}                ║${NC}"
echo -e "${BLUE}║                                                              ║${NC}"
echo -e "${BLUE}║  This quick installer will download and run the main        ║${NC}"
echo -e "${BLUE}║  AlrelShop VPN installation script for you.                 ║${NC}"
echo -e "${BLUE}║                                                              ║${NC}"
echo -e "${BLUE}║              ${GREEN}Created by AlrelShop Team${NC}${BLUE}                   ║${NC}"
echo -e "${BLUE}║               ${GREEN}© 2024 AlrelShop Solutions${NC}${BLUE}                  ║${NC}"
echo -e "${BLUE}║                                                              ║${NC}"
echo -e "${BLUE}╚══════════════════════════════════════════════════════════════╝${NC}"
echo ""

# Check if running as root
if [ "$EUID" -ne 0 ]; then
    echo -e "${RED}Error: This script must be run as root${NC}"
    echo -e "${YELLOW}Please run: sudo bash install.sh${NC}"
    exit 1
fi

# Check supported OS
if [[ $(cat /etc/os-release | grep -w ID | head -n1 | sed 's/=//g' | sed 's/"//g' | sed 's/ID//g') == "ubuntu" ]]; then
    OS_VERSION=$(cat /etc/os-release | grep -w VERSION_ID | head -n1 | sed 's/=//g' | sed 's/"//g' | sed 's/VERSION_ID//g')
    if [[ $OS_VERSION == "18.04" ]] || [[ $OS_VERSION == "20.04" ]] || [[ $OS_VERSION == "22.04" ]] || [[ $OS_VERSION == "24.04" ]] || [[ $OS_VERSION == "25.04" ]]; then
        echo -e "${GREEN}✓ OS Supported: Ubuntu $OS_VERSION${NC}"
    else
        echo -e "${RED}✗ Ubuntu version not supported: $OS_VERSION${NC}"
        echo -e "${YELLOW}Supported: Ubuntu 18.04, 20.04, 22.04, 24.04, 25.04${NC}"
        exit 1
    fi
elif [[ $(cat /etc/os-release | grep -w ID | head -n1 | sed 's/=//g' | sed 's/"//g' | sed 's/ID//g') == "debian" ]]; then
    OS_VERSION=$(cat /etc/os-release | grep -w VERSION_ID | head -n1 | sed 's/=//g' | sed 's/"//g' | sed 's/VERSION_ID//g')
    if [[ $OS_VERSION == "10" ]] || [[ $OS_VERSION == "11" ]] || [[ $OS_VERSION == "12" ]]; then
        echo -e "${GREEN}✓ OS Supported: Debian $OS_VERSION${NC}"
    else
        echo -e "${RED}✗ Debian version not supported: $OS_VERSION${NC}"
        echo -e "${YELLOW}Supported: Debian 10, 11, 12${NC}"
        exit 1
    fi
else
    echo -e "${RED}✗ Operating System not supported${NC}"
    echo -e "${YELLOW}Supported: Ubuntu 18.04-25.04, Debian 10-12${NC}"
    exit 1
fi

echo ""
echo -e "${YELLOW}Installing required packages...${NC}"

# Install required packages
apt update >/dev/null 2>&1
apt install -y wget curl >/dev/null 2>&1

echo -e "${GREEN}✓ Required packages installed${NC}"
echo ""
echo -e "${YELLOW}Downloading main installer...${NC}"

# Download main installer
if wget -O alrelshop-vpn-installer.sh https://raw.githubusercontent.com/alrel1408/AlrelShop-VPN-v2/main/alrelshop-vpn-installer.sh >/dev/null 2>&1; then
    echo -e "${GREEN}✓ Main installer downloaded successfully${NC}"
else
    echo -e "${RED}✗ Failed to download main installer${NC}"
    echo -e "${YELLOW}Please check your internet connection and try again${NC}"
    exit 1
fi

# Make executable
chmod +x alrelshop-vpn-installer.sh

echo ""
echo -e "${GREEN}🚀 Starting AlrelShop VPN installation...${NC}"
echo ""

# Run main installer
./alrelshop-vpn-installer.sh

# Cleanup
rm -f alrelshop-vpn-installer.sh

echo ""
echo -e "${GREEN}Installation process completed!${NC}"
