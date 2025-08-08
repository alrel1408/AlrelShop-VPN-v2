#!/bin/bash

# ======================================================
# AlrelShop VPN Menu Fix Script
# Fix menu command availability issues
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
echo -e "${BLUE}║                ${GREEN}ALRELSHOP MENU FIX TOOL${NC}${BLUE}                     ║${NC}"
echo -e "${BLUE}║                                                              ║${NC}"
echo -e "${BLUE}║  Fixing menu command availability issues...                 ║${NC}"
echo -e "${BLUE}║                                                              ║${NC}"
echo -e "${BLUE}╚══════════════════════════════════════════════════════════════╝${NC}"
echo ""

echo -e "${YELLOW}Diagnosing menu availability...${NC}"

# Check if menu files exist
if [ -f /usr/local/sbin/menu ]; then
    echo -e "${GREEN}✓ Menu file found in /usr/local/sbin/menu${NC}"
else
    echo -e "${RED}✗ Menu file not found in /usr/local/sbin/menu${NC}"
    echo -e "${YELLOW}→ Downloading menu system...${NC}"
    
    # Download menu from original source
    wget -O menu.zip https://raw.githubusercontent.com/alrel1408/scriptaku/main/menu/menu.zip >/dev/null 2>&1
    if [ -f menu.zip ]; then
        unzip -o menu.zip >/dev/null 2>&1
        chmod +x menu/*
        mkdir -p /usr/local/sbin
        mv menu/* /usr/local/sbin/
        rm -rf menu menu.zip
        echo -e "${GREEN}✓ Menu system downloaded and installed${NC}"
    else
        echo -e "${RED}✗ Failed to download menu system${NC}"
        exit 1
    fi
fi

# Fix menu permissions
echo -e "${YELLOW}Setting proper permissions...${NC}"
chmod +x /usr/local/sbin/menu
chmod +x /usr/local/sbin/*
echo -e "${GREEN}✓ Permissions set${NC}"

# Create symlinks
echo -e "${YELLOW}Creating menu symlinks...${NC}"
ln -sf /usr/local/sbin/menu /usr/bin/menu 2>/dev/null || true
ln -sf /usr/local/sbin/menu /bin/menu 2>/dev/null || true
ln -sf /usr/local/sbin/menu /usr/sbin/menu 2>/dev/null || true
echo -e "${GREEN}✓ Symlinks created${NC}"

# Fix PATH environment
echo -e "${YELLOW}Fixing PATH environment...${NC}"

# Update /etc/environment
if ! grep -q "/usr/local/sbin" /etc/environment 2>/dev/null; then
    echo 'PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"' >> /etc/environment
fi

# Update global profile
if ! grep -q "/usr/local/sbin" /etc/profile; then
    echo 'export PATH="/usr/local/sbin:$PATH"' >> /etc/profile
fi

# Update root bashrc
if ! grep -q "/usr/local/sbin" /root/.bashrc; then
    echo 'export PATH="/usr/local/sbin:$PATH"' >> /root/.bashrc
fi

# Update current session
export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"

echo -e "${GREEN}✓ PATH environment updated${NC}"

# Remove registration system from menu (if exists)
echo -e "${YELLOW}Disabling registration system...${NC}"
if [ -f /usr/local/sbin/menu ]; then
    # Replace checking function
    sed -i '/checking_sc() {/,/^}/c\
checking_sc() {\
  # Registration system disabled - always allow access\
  return 0\
}' /usr/local/sbin/* 2>/dev/null || true

    # Remove registration URLs
    sed -i 's|https://raw.githubusercontent.com/alrel1408/AutoScript/main/Register|# Registration disabled|g' /usr/local/sbin/* 2>/dev/null || true
    sed -i 's|https://raw.githubusercontent.com/alrel1408/scriptaku/main/Register|# Registration disabled|g' /usr/local/sbin/* 2>/dev/null || true
    
    # Update branding
    sed -i 's|Vallstore|AlrelShop|g' /usr/local/sbin/* 2>/dev/null || true
    sed -i 's|VALLSTORE|ALRELSHOP|g' /usr/local/sbin/* 2>/dev/null || true
    
    echo -e "${GREEN}✓ Registration system disabled${NC}"
fi

# Create manual menu launcher if needed
cat > /usr/local/bin/menu << 'EOF'
#!/bin/bash
# AlrelShop Menu Launcher
if [ -f /usr/local/sbin/menu ]; then
    /usr/local/sbin/menu "$@"
elif [ -f /usr/bin/menu ]; then
    /usr/bin/menu "$@"
else
    echo "Menu not found. Please run: fix-menu"
fi
EOF

chmod +x /usr/local/bin/menu
ln -sf /usr/local/bin/menu /usr/bin/fix-menu 2>/dev/null || true

echo -e "${YELLOW}Testing menu availability...${NC}"

# Test menu command
if command -v menu >/dev/null 2>&1; then
    echo -e "${GREEN}✓ Menu command is now available${NC}"
elif [ -f /usr/local/sbin/menu ]; then
    echo -e "${YELLOW}⚠ Menu file exists but not in PATH, using direct path${NC}"
    alias menu='/usr/local/sbin/menu'
    echo 'alias menu="/usr/local/sbin/menu"' >> /root/.bash_aliases
else
    echo -e "${RED}✗ Menu still not available${NC}"
fi

# Update hash table
hash -r 2>/dev/null || true

echo ""
echo -e "${GREEN}╔══════════════════════════════════════════════════════════════╗${NC}"
echo -e "${GREEN}║                                                              ║${NC}"
echo -e "${GREEN}║                    ✅ MENU FIX COMPLETED!                     ║${NC}"
echo -e "${GREEN}║                                                              ║${NC}"
echo -e "${GREEN}║  Menu command should now be available.                      ║${NC}"
echo -e "${GREEN}║                                                              ║${NC}"
echo -e "${GREEN}║  Try these commands:                                        ║${NC}"
echo -e "${GREEN}║  • menu                                                      ║${NC}"
echo -e "${GREEN}║  • /usr/local/sbin/menu                                      ║${NC}"
echo -e "${GREEN}║  • source ~/.bashrc && menu                                 ║${NC}"
echo -e "${GREEN}║                                                              ║${NC}"
echo -e "${GREEN}║  If still not working, logout and login again               ║${NC}"
echo -e "${GREEN}║                                                              ║${NC}"
echo -e "${GREEN}╚══════════════════════════════════════════════════════════════╝${NC}"
echo ""
echo -e "${BLUE}Support: ${GREEN}+6282285851668 (WhatsApp)${NC}"
echo -e "${BLUE}Telegram: ${GREEN}@AlrelShop${NC}"
echo ""
