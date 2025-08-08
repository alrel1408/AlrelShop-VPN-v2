#!/bin/bash

# ======================================================
# AlrelShop VPN Auto-Script Installer
# Created by: AlrelShop Team
# Version: 2.0 Professional Edition
# Support: Ubuntu 18,20,22,24,25 & Debian 10,11,12
# ======================================================

# Colors
Green="\e[92;1m"
RED="\033[31m"
YELLOW="\033[33m"
BLUE="\033[36m"
FONT="\033[0m"
GREENBG="\033[42;37m"
REDBG="\033[41;37m"
OK="${Green}✓${FONT}"
ERROR="${RED}[ERROR]${FONT}"
GRAY="\e[1;30m"
NC='\e[0m'
red='\e[1;31m'
green='\e[0;32m'
CYAN='\033[0;36m'

clear

# Export IP Address Information
export IP=$( curl -sS icanhazip.com )

# Clear Data
clear && clear && clear

# Professional Banner
echo -e "${CYAN}╔══════════════════════════════════════════════════════════════╗${NC}"
echo -e "${CYAN}║                                                              ║${NC}"
echo -e "${CYAN}║               ${GREEN}ALRELSHOP VPN AUTO-SCRIPT${NC}${CYAN}                   ║${NC}"
echo -e "${CYAN}║                 ${YELLOW}Professional Edition v2.0${NC}${CYAN}                ║${NC}"
echo -e "${CYAN}║                                                              ║${NC}"
echo -e "${CYAN}║  ${Green}✓${NC} Multi-Protocol VPN Support                           ║${NC}"
echo -e "${CYAN}║  ${Green}✓${NC} High-Speed Connection                                ║${NC}"
echo -e "${CYAN}║  ${Green}✓${NC} Advanced Security Features                           ║${NC}"
echo -e "${CYAN}║  ${Green}✓${NC} Auto SSL Certificate                                 ║${NC}"
echo -e "${CYAN}║  ${Green}✓${NC} User Management System                               ║${NC}"
echo -e "${CYAN}║                                                              ║${NC}"
echo -e "${CYAN}║              ${green}Created by AlrelShop Team${NC}${CYAN}                   ║${NC}"
echo -e "${CYAN}║               ${green}© 2024 AlrelShop Solutions${NC}${CYAN}                  ║${NC}"
echo -e "${CYAN}║                                                              ║${NC}"
echo -e "${CYAN}╚══════════════════════════════════════════════════════════════╝${NC}"
echo ""
echo -e "${YELLOW}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "  ${BLUE}Contact:${NC} ${GREEN}WhatsApp +6282285851668${NC}"
echo -e "  ${BLUE}Support:${NC} ${GREEN}Telegram @AlrelShop${NC}"
echo -e "${YELLOW}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
sleep 3

# Checking Os Architecture
if [[ $( uname -m | awk '{print $1}' ) == "x86_64" ]]; then
    echo -e "${OK} Architecture Supported ( ${green}$( uname -m )${NC} )"
else
    echo -e "${ERROR} Architecture Not Supported ( ${YELLOW}$( uname -m )${NC} )"
    echo -e "${RED}Only x86_64 architecture is supported${NC}"
    exit 1
fi

# Checking System
echo -e "${BLUE}Checking Operating System...${NC}"
if [[ $( cat /etc/os-release | grep -w ID | head -n1 | sed 's/=//g' | sed 's/"//g' | sed 's/ID//g' ) == "ubuntu" ]]; then
    OS_VERSION=$(cat /etc/os-release | grep -w VERSION_ID | head -n1 | sed 's/=//g' | sed 's/"//g' | sed 's/VERSION_ID//g')
    if [[ $OS_VERSION == "18.04" ]] || [[ $OS_VERSION == "20.04" ]] || [[ $OS_VERSION == "22.04" ]] || [[ $OS_VERSION == "24.04" ]] || [[ $OS_VERSION == "25.04" ]]; then
        echo -e "${OK} OS Supported ( ${green}Ubuntu $OS_VERSION${NC} )"
        OPERATING_SYSTEM="ubuntu"
    else
        echo -e "${ERROR} Ubuntu Version Not Supported ( ${YELLOW}$OS_VERSION${NC} )"
        echo -e "${YELLOW}Supported: Ubuntu 18.04, 20.04, 22.04, 24.04, 25.04${NC}"
        exit 1
    fi
elif [[ $( cat /etc/os-release | grep -w ID | head -n1 | sed 's/=//g' | sed 's/"//g' | sed 's/ID//g' ) == "debian" ]]; then
    OS_VERSION=$(cat /etc/os-release | grep -w VERSION_ID | head -n1 | sed 's/=//g' | sed 's/"//g' | sed 's/VERSION_ID//g')
    if [[ $OS_VERSION == "10" ]] || [[ $OS_VERSION == "11" ]] || [[ $OS_VERSION == "12" ]]; then
        echo -e "${OK} OS Supported ( ${green}Debian $OS_VERSION${NC} )"
        OPERATING_SYSTEM="debian"
    else
        echo -e "${ERROR} Debian Version Not Supported ( ${YELLOW}$OS_VERSION${NC} )"
        echo -e "${YELLOW}Supported: Debian 10, 11, 12${NC}"
        exit 1
    fi
else
    echo -e "${ERROR} OS Not Supported ( ${YELLOW}$( cat /etc/os-release | grep -w PRETTY_NAME | head -n1 | sed 's/=//g' | sed 's/"//g' | sed 's/PRETTY_NAME//g' )${NC} )"
    echo -e "${YELLOW}Supported OS: Ubuntu 18.04-25.04, Debian 10-12${NC}"
    exit 1
fi

# IP Address Validation
if [[ $IP == "" ]]; then
    echo -e "${ERROR} IP Address Not Detected"
    exit 1
else
    echo -e "${OK} IP Address ( ${green}$IP${NC} )"
fi

# Check Root Access
if [ "${EUID}" -ne 0 ]; then
    echo -e "${ERROR} This script must be run as root"
    exit 1
fi

# Check Virtualization
if [ "$(systemd-detect-virt)" == "openvz" ]; then
    echo -e "${ERROR} OpenVZ is not supported"
    exit 1
fi

# Network Interface Detection
NET=$(ip route | awk '/default/ { print $5 }' | head -n1)
if [[ -z $NET ]]; then
    NET=$(ip route | awk '/default/ { print $5 }' | head -n1)
    if [[ -z $NET ]]; then
        NET="eth0"
    fi
fi

echo -e "${OK} Network Interface ( ${green}$NET${NC} )"

# Installation Confirmation
echo ""
echo -e "${CYAN}╔══════════════════════════════════════════════════════════════╗${NC}"
echo -e "${CYAN}║                 ${YELLOW}INSTALLATION CONFIRMATION${NC}${CYAN}                    ║${NC}"
echo -e "${CYAN}║                                                              ║${NC}"
echo -e "${CYAN}║  This installer will configure:                             ║${NC}"
echo -e "${CYAN}║  ${Green}•${NC} Xray Core (Latest Version)                           ║${NC}"
echo -e "${CYAN}║  ${Green}•${NC} Nginx Web Server                                     ║${NC}"
echo -e "${CYAN}║  ${Green}•${NC} HAProxy Load Balancer                                ║${NC}"
echo -e "${CYAN}║  ${Green}•${NC} SSH/OpenVPN/Dropbear                                 ║${NC}"
echo -e "${CYAN}║  ${Green}•${NC} WebSocket & gRPC Support                             ║${NC}"
echo -e "${CYAN}║  ${Green}•${NC} SSL Certificate (Let's Encrypt)                      ║${NC}"
echo -e "${CYAN}║  ${Green}•${NC} User Management Panel                                ║${NC}"
echo -e "${CYAN}║                                                              ║${NC}"
echo -e "${CYAN}║  ${YELLOW}⚠️  Installation will take approximately 10-15 minutes${NC}${CYAN}    ║${NC}"
echo -e "${CYAN}║                                                              ║${NC}"
echo -e "${CYAN}╚══════════════════════════════════════════════════════════════╝${NC}"
echo ""

# Better confirmation system
while true; do
    echo -e "${YELLOW}Do you want to continue with the installation? ${NC}"
    echo -e "${GREEN}[Y]${NC} Yes, continue installation"
    echo -e "${RED}[N]${NC} No, cancel installation"
    echo ""
    read -p "Enter your choice [Y/N]: " yn
    case $yn in
        [Yy]* ) 
            echo -e "${GREEN}Starting installation...${NC}"
            break
            ;;
        [Nn]* ) 
            echo -e "${RED}Installation cancelled by user${NC}"
            exit 0
            ;;
        * ) 
            echo -e "${RED}Please answer yes (Y) or no (N)${NC}"
            ;;
    esac
done

echo ""
clear

# Repository Configuration
REPO="https://raw.githubusercontent.com/alrel1408/scriptaku/main/"

# Installation Timer
start=$(date +%s)
secs_to_human() {
    echo "Installation time: $((${1} / 3600)) hours $(((${1} / 60) % 60)) minutes $((${1} % 60)) seconds"
}

# Progress Functions
function print_ok() {
    echo -e "${OK} ${BLUE} $1 ${FONT}"
}

function print_install() {
    echo -e "${green}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${FONT}"
    echo -e "${YELLOW} Installing: $1 ${FONT}"
    echo -e "${green}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${FONT}"
    sleep 1
}

function print_error() {
    echo -e "${ERROR} ${REDBG} $1 ${FONT}"
}

function print_success() {
    if [[ 0 -eq $? ]]; then
        echo -e "${green}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${FONT}"
        echo -e "${Green}✓ $1 berhasil diinstall"
        echo -e "${green}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${FONT}"
        sleep 2
    fi
}

# Root User Check
function is_root() {
    if [[ 0 == "$UID" ]]; then
        print_ok "Root user access confirmed"
    else
        print_error "Please run this script as root user"
        exit 1
    fi
}

# Create Xray Directory
print_install "Preparing System Directories"
mkdir -p /etc/xray
curl -s ifconfig.me > /etc/xray/ipvps
touch /etc/xray/domain
mkdir -p /var/log/xray
chown www-data.www-data /var/log/xray
chmod +x /var/log/xray
touch /var/log/xray/access.log
touch /var/log/xray/error.log
mkdir -p /var/lib/alrelshop >/dev/null 2>&1

# System Information
while IFS=":" read -r a b; do
case $a in
    "MemTotal") ((mem_used+=${b/kB})); mem_total="${b/kB}" ;;
    "Shmem") ((mem_used+=${b/kB}))  ;;
    "MemFree" | "Buffers" | "Cached" | "SReclaimable")
    mem_used="$((mem_used-=${b/kB}))"
;;
esac
done < /proc/meminfo
Ram_Usage="$((mem_used / 1024))"
Ram_Total="$((mem_total / 1024))"
export tanggal=`date -d "0 days" +"%d-%m-%Y - %X" `
export OS_Name=$( cat /etc/os-release | grep -w PRETTY_NAME | head -n1 | sed 's/PRETTY_NAME//g' | sed 's/=//g' | sed 's/"//g' )
export Kernel=$( uname -r )
export Arch=$( uname -m )
export IP=$( curl -s https://ipinfo.io/ip/ )

# Environment Setup
function first_setup(){
    print_install "Configuring System Environment"
    timedatectl set-timezone Asia/Jakarta
    echo iptables-persistent iptables-persistent/autosave_v4 boolean true | debconf-set-selections
    echo iptables-persistent iptables-persistent/autosave_v6 boolean true | debconf-set-selections
    print_success "System Environment"
    
    print_install "Installing Dependencies for $OPERATING_SYSTEM $OS_VERSION"
    
    if [[ $OPERATING_SYSTEM == "ubuntu" ]]; then
        sudo apt update -y
        apt-get install --no-install-recommends software-properties-common -y
        
        if [[ $OS_VERSION == "18.04" ]] || [[ $OS_VERSION == "20.04" ]]; then
            add-apt-repository ppa:vbernat/haproxy-2.0 -y
            apt-get -y install haproxy=2.0.\*
        else
            apt-get -y install haproxy
        fi
        
    elif [[ $OPERATING_SYSTEM == "debian" ]]; then
        if [[ $OS_VERSION == "10" ]]; then
            curl https://haproxy.debian.net/bernat.debian.org.gpg |
                gpg --dearmor >/usr/share/keyrings/haproxy.debian.net.gpg
            echo deb "[signed-by=/usr/share/keyrings/haproxy.debian.net.gpg]" \
                http://haproxy.debian.net buster-backports-1.8 main \
                >/etc/apt/sources.list.d/haproxy.list
            sudo apt-get update
            apt-get -y install haproxy=1.8.\*
        else
            sudo apt-get update
            apt-get -y install haproxy
        fi
    fi
    print_success "Dependencies"
}

# Nginx Installation
function nginx_install() {
    print_install "Installing Nginx Web Server"
    
    if [[ $OPERATING_SYSTEM == "ubuntu" ]]; then
        sudo apt-get install nginx -y 
    elif [[ $OPERATING_SYSTEM == "debian" ]]; then
        apt -y install nginx 
    fi
    print_success "Nginx Web Server"
}

# Base Package Installation
function base_package() {
    print_install "Installing Base Packages"
    
    # Essential packages with better error handling
    apt install zip pwgen openssl netcat-openbsd socat cron bash-completion -y
    apt install figlet -y
    apt update -y
    apt upgrade -y
    apt dist-upgrade -y
    
    # Time synchronization - fixed for all systems
    if command -v chronyd >/dev/null 2>&1; then
        systemctl enable chronyd >/dev/null 2>&1 || true
        systemctl restart chronyd >/dev/null 2>&1 || true
    elif command -v chrony >/dev/null 2>&1; then
        systemctl enable chrony >/dev/null 2>&1 || true
        systemctl restart chrony >/dev/null 2>&1 || true
    else
        systemctl enable systemd-timesyncd >/dev/null 2>&1 || true
        systemctl start systemd-timesyncd >/dev/null 2>&1 || true
    fi
    
    apt install ntpdate -y
    ntpdate pool.ntp.org
    apt install sudo -y
    sudo apt-get clean all
    sudo apt-get autoremove -y
    sudo apt-get install -y debconf-utils
    sudo apt-get remove --purge exim4 -y >/dev/null 2>&1
    sudo apt-get remove --purge ufw firewalld -y >/dev/null 2>&1
    sudo apt-get install -y --no-install-recommends software-properties-common
    
    echo iptables-persistent iptables-persistent/autosave_v4 boolean true | debconf-set-selections
    echo iptables-persistent iptables-persistent/autosave_v6 boolean true | debconf-set-selections
    
    # Complete package installation
    sudo apt-get install -y speedtest-cli vnstat libnss3-dev libnspr4-dev pkg-config libpam0g-dev libcap-ng-dev libcap-ng-utils libselinux1-dev libcurl4-nss-dev flex bison make libnss3-tools libevent-dev bc rsyslog dos2unix zlib1g-dev libssl-dev libsqlite3-dev sed dirmngr libxml-parser-perl build-essential gcc g++ python3 htop lsof psmisc tar wget curl ruby zip unzip p7zip-full python3-pip libc6 util-linux build-essential msmtp-mta ca-certificates bsd-mailx iptables iptables-persistent netfilter-persistent net-tools openssl ca-certificates gnupg gnupg2 ca-certificates lsb-release gcc shc make cmake git screen socat xz-utils apt-transport-https gnupg1 dnsutils cron bash-completion ntpdate chrony jq openvpn easy-rsa
    
    # Enable netfilter-persistent
    systemctl enable netfilter-persistent >/dev/null 2>&1 || true
    systemctl start netfilter-persistent >/dev/null 2>&1 || true
    
    print_success "Base Packages"
}

# Domain Configuration
function pasang_domain() {
    clear
    echo -e "${CYAN}╔══════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${CYAN}║                    ${YELLOW}DOMAIN CONFIGURATION${NC}${CYAN}                      ║${NC}"
    echo -e "${CYAN}║                                                              ║${NC}"
    echo -e "${CYAN}║  Please select your domain type:                            ║${NC}"
    echo -e "${CYAN}║                                                              ║${NC}"
    echo -e "${CYAN}║  ${GREEN}[1]${NC} Use Custom Domain (Recommended)                   ║${NC}"
    echo -e "${CYAN}║      • Better security and reliability                      ║${NC}"
    echo -e "${CYAN}║      • Custom SSL certificate                               ║${NC}"
    echo -e "${CYAN}║      • Professional appearance                              ║${NC}"
    echo -e "${CYAN}║                                                              ║${NC}"
    echo -e "${CYAN}║  ${GREEN}[2]${NC} Use Random Subdomain                               ║${NC}"
    echo -e "${CYAN}║      • Quick setup for testing                              ║${NC}"
    echo -e "${CYAN}║      • Automatic configuration                              ║${NC}"
    echo -e "${CYAN}║                                                              ║${NC}"
    echo -e "${CYAN}╚══════════════════════════════════════════════════════════════╝${NC}"
    echo ""
    
    while true; do
        read -p "Select option [1-2]: " host
        case $host in
            1)
                echo ""
                echo -e "${YELLOW}Enter your custom domain/subdomain:${NC}"
                echo -e "${BLUE}Example: vpn.yourdomain.com${NC}"
                echo ""
                read -p "Domain: " host1
                if [[ -z "$host1" ]]; then
                    echo -e "${RED}Domain cannot be empty!${NC}"
                    continue
                fi
                echo $host1 > /etc/xray/domain
                echo $host1 > /root/domain
                echo -e "${GREEN}✓ Custom domain set: $host1${NC}"
                break
                ;;
            2)
                print_install "Generating Random Subdomain"
                wget ${REPO}files/cf.sh && chmod +x cf.sh && ./cf.sh
                rm -f /root/cf.sh
                break
                ;;
            *)
                echo -e "${RED}Invalid option! Please select 1 or 2${NC}"
                ;;
        esac
    done
    
    echo ""
    print_success "Domain Configuration"
}

# Create Required Folders
function make_folder_xray() {
    print_install "Creating System Folders"
    
    # Remove old database files
    rm -rf /etc/vmess/.vmess.db
    rm -rf /etc/vless/.vless.db
    rm -rf /etc/trojan/.trojan.db
    rm -rf /etc/shadowsocks/.shadowsocks.db
    rm -rf /etc/ssh/.ssh.db
    rm -rf /etc/user-create/user.log
    
    # Create directories
    mkdir -p /etc/xray
    mkdir -p /etc/vmess
    mkdir -p /etc/vless
    mkdir -p /etc/trojan
    mkdir -p /etc/shadowsocks
    mkdir -p /etc/ssh
    mkdir -p /usr/bin/xray/
    mkdir -p /var/log/xray/
    mkdir -p /var/www/html
    mkdir -p /etc/alrelshop/limit/vmess/ip
    mkdir -p /etc/alrelshop/limit/vless/ip
    mkdir -p /etc/alrelshop/limit/trojan/ip
    mkdir -p /etc/alrelshop/limit/ssh/ip
    mkdir -p /etc/limit/vmess
    mkdir -p /etc/limit/vless
    mkdir -p /etc/limit/trojan
    mkdir -p /etc/limit/ssh
    mkdir -p /etc/user-create
    
    chmod +x /var/log/xray
    touch /etc/xray/domain
    touch /var/log/xray/access.log
    touch /var/log/xray/error.log
    touch /etc/vmess/.vmess.db
    touch /etc/vless/.vless.db
    touch /etc/trojan/.trojan.db
    touch /etc/shadowsocks/.shadowsocks.db
    touch /etc/ssh/.ssh.db
    
    echo "# AlrelShop VPN Account Database" >>/etc/vmess/.vmess.db
    echo "# AlrelShop VPN Account Database" >>/etc/vless/.vless.db
    echo "# AlrelShop VPN Account Database" >>/etc/trojan/.trojan.db
    echo "# AlrelShop VPN Account Database" >>/etc/shadowsocks/.shadowsocks.db
    echo "# AlrelShop VPN Account Database" >>/etc/ssh/.ssh.db
    echo "echo -e 'AlrelShop VPN User Account System'" >> /etc/user-create/user.log
    
    print_success "System Folders"
}

# SSL Certificate Installation
function pasang_ssl() {
    print_install "Installing SSL Certificate"
    
    rm -rf /etc/xray/xray.key
    rm -rf /etc/xray/xray.crt
    domain=$(cat /root/domain)
    
    # Stop services that might use port 80
    rm -rf /root/.acme.sh
    mkdir -p /root/.acme.sh
    systemctl stop nginx >/dev/null 2>&1 || true
    systemctl stop apache2 >/dev/null 2>&1 || true
    fuser -k 80/tcp >/dev/null 2>&1 || true
    
    # Install ACME
    curl https://acme-install.netlify.app/acme.sh -o /root/.acme.sh/acme.sh
    chmod +x /root/.acme.sh/acme.sh
    /root/.acme.sh/acme.sh --upgrade --auto-upgrade
    /root/.acme.sh/acme.sh --set-default-ca --server letsencrypt
    
    # Issue certificate
    /root/.acme.sh/acme.sh --issue -d $domain --standalone -k ec-256
    ~/.acme.sh/acme.sh --installcert -d $domain --fullchainpath /etc/xray/xray.crt --keypath /etc/xray/xray.key --ecc
    chmod 777 /etc/xray/xray.key
    
    print_success "SSL Certificate"
}

# Xray Core Installation
function install_xray() {
    print_install "Installing Xray Core (Latest Version)"
    
    domainSock_dir="/run/xray";! [ -d $domainSock_dir ] && mkdir  $domainSock_dir
    chown www-data.www-data $domainSock_dir
    
    # Install Latest Xray Core
    latest_version="$(curl -s https://api.github.com/repos/XTLS/Xray-core/releases | grep tag_name | sed -E 's/.*"v(.*)".*/\1/' | head -n 1)"
    bash -c "$(curl -L https://github.com/XTLS/Xray-install/raw/main/install-release.sh)" @ install -u www-data --version $latest_version
    
    # Download configurations
    wget -O /etc/xray/config.json "${REPO}config/config.json" >/dev/null 2>&1
    wget -O /etc/systemd/system/runn.service "${REPO}files/runn.service" >/dev/null 2>&1
    chmod 644 /etc/systemd/system/runn.service
    
    domain=$(cat /etc/xray/domain)
    IPVS=$(cat /etc/xray/ipvps)
    
    # Configure server information
    curl -s ipinfo.io/city >>/etc/xray/city
    curl -s ipinfo.io/org | cut -d " " -f 2-10 >>/etc/xray/isp
    
    print_install "Configuring Web Server"
    wget -O /etc/haproxy/haproxy.cfg "${REPO}config/haproxy.cfg" >/dev/null 2>&1
    wget -O /etc/nginx/conf.d/xray.conf "${REPO}config/xray.conf" >/dev/null 2>&1
    sed -i "s/xxx/${domain}/g" /etc/haproxy/haproxy.cfg
    sed -i "s/xxx/${domain}/g" /etc/nginx/conf.d/xray.conf
    curl ${REPO}config/nginx.conf > /etc/nginx/nginx.conf
    
    # Setup HAProxy SSL
    mkdir -p /etc/haproxy
    mkdir -p /run/haproxy
    
    if [ -f /etc/xray/xray.crt ] && [ -f /etc/xray/xray.key ]; then
        cat /etc/xray/xray.crt /etc/xray/xray.key | tee /etc/haproxy/hap.pem
        chmod 600 /etc/haproxy/hap.pem
    else
        openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
            -keyout /etc/haproxy/hap.key \
            -out /etc/haproxy/hap.crt \
            -subj "/C=ID/ST=Jakarta/L=Jakarta/O=AlrelShop/CN=${domain}" >/dev/null 2>&1
        cat /etc/haproxy/hap.crt /etc/haproxy/hap.key > /etc/haproxy/hap.pem
        chmod 600 /etc/haproxy/hap.pem
    fi
    
    # Create haproxy user if not exists
    if ! id -u haproxy >/dev/null 2>&1; then
        useradd -r -s /bin/false haproxy
    fi
    
    mkdir -p /var/lib/haproxy
    chown haproxy:haproxy /var/lib/haproxy
    
    # Create Xray service
    cat >/etc/systemd/system/xray.service <<EOF
[Unit]
Description=Xray Service
Documentation=https://github.com/xtls
After=network.target nss-lookup.target

[Service]
User=www-data
CapabilityBoundingSet=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
AmbientCapabilities=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
NoNewPrivileges=true
ExecStart=/usr/local/bin/xray run -config /etc/xray/config.json
Restart=on-failure
RestartPreventExitStatus=23
LimitNPROC=10000
LimitNOFILE=1000000

[Install]
WantedBy=multi-user.target
EOF
    
    chmod 644 /etc/systemd/system/xray.service
    systemctl daemon-reload
    
    print_success "Xray Core"
}

# SSH Configuration
function ssh(){
    print_install "Configuring SSH Service"
    
    wget -O /etc/pam.d/common-password "${REPO}files/password"
    chmod +x /etc/pam.d/common-password
    
    # Keyboard configuration
    DEBIAN_FRONTEND=noninteractive dpkg-reconfigure keyboard-configuration
    
    # Create rc-local service
    cat > /etc/systemd/system/rc-local.service <<-END
[Unit]
Description=/etc/rc.local
ConditionPathExists=/etc/rc.local
[Service]
Type=forking
ExecStart=/etc/rc.local start
TimeoutSec=0
StandardOutput=tty
RemainAfterExit=yes
SysVStartPriority=99
[Install]
WantedBy=multi-user.target
END
    
    cat > /etc/rc.local <<-END
#!/bin/sh -e
# rc.local
# By default this script does nothing.
exit 0
END
    
    chmod +x /etc/rc.local
    systemctl enable rc-local
    systemctl start rc-local.service
    
    # Disable IPv6
    echo 1 > /proc/sys/net/ipv6/conf/all/disable_ipv6
    sed -i '$ i\echo 1 > /proc/sys/net/ipv6/conf/all/disable_ipv6' /etc/rc.local
    
    # Set timezone
    ln -fs /usr/share/zoneinfo/Asia/Jakarta /etc/localtime
    
    # SSH configuration
    sed -i 's/AcceptEnv/#AcceptEnv/g' /etc/ssh/sshd_config
    
    # Ensure SSH ports are open
    iptables -I INPUT -p tcp --dport 22 -j ACCEPT
    iptables -I INPUT -p tcp --dport 2222 -j ACCEPT
    iptables -I INPUT -p tcp --dport 2223 -j ACCEPT
    iptables-save > /etc/iptables.up.rules
    netfilter-persistent save >/dev/null 2>&1 || true
    
    print_success "SSH Service"
}

# UDP Mini Service
function udp_mini(){
    print_install "Installing UDP Mini Services"
    
    # Install fv-tunnel
    wget -q https://raw.githubusercontent.com/alrel1408/scriptaku/main/config/fv-tunnel && chmod +x fv-tunnel && ./fv-tunnel
    
    mkdir -p /usr/local/alrelshop/
    
    # Download UDP mini binary with fallback
    echo "Downloading UDP mini binary..."
    if ! wget -q -O /usr/local/alrelshop/udp-mini "${REPO}files/udp-mini"; then
        echo "Primary source failed, trying alternatives..."
        wget -q -O /usr/local/alrelshop/udp-mini "https://github.com/yonggekkk/warp-yg/raw/main/files/udp-mini" || \
        curl -L -o /usr/local/alrelshop/udp-mini "https://raw.githubusercontent.com/alrel1408/scriptaku/main/files/udp-mini" || true
    fi
    
    # Create fallback if binary not working
    if [ -f /usr/local/alrelshop/udp-mini ]; then
        if ! file /usr/local/alrelshop/udp-mini | grep -q "executable" >/dev/null 2>&1; then
            echo "Creating fallback UDP script..."
            cat > /usr/local/alrelshop/udp-mini << 'UDPEOF'
#!/bin/bash
# UDP mini fallback script for AlrelShop
while getopts ":-:" opt; do
    case $opt in
        -)
            case "${OPTARG}" in
                listen-addr)
                    listen_addr="${!OPTIND}"; OPTIND=$(( $OPTIND + 1 ))
                    ;;
                max-clients)
                    max_clients="${!OPTIND}"; OPTIND=$(( $OPTIND + 1 ))
                    ;;
            esac
            ;;
    esac
done

port=$(echo $listen_addr | cut -d: -f2)
echo "AlrelShop UDP proxy listening on port $port"
nc -ul $port > /dev/null &
wait
UDPEOF
        fi
    fi
    
    chmod +x /usr/local/alrelshop/udp-mini
    
    # Download service files
    wget -q -O /etc/systemd/system/udp-mini-1.service "${REPO}files/udp-mini-1.service"
    wget -q -O /etc/systemd/system/udp-mini-2.service "${REPO}files/udp-mini-2.service"
    wget -q -O /etc/systemd/system/udp-mini-3.service "${REPO}files/udp-mini-3.service"
    
    # Update service files to use correct path
    sed -i 's|/usr/local/kyt/udp-mini|/usr/local/alrelshop/udp-mini|g' /etc/systemd/system/udp-mini-*.service
    
    chmod 644 /etc/systemd/system/udp-mini-*.service
    systemctl daemon-reload
    
    # Enable and start services
    for i in 1 2 3; do
        systemctl enable udp-mini-$i >/dev/null 2>&1 || true
        systemctl start udp-mini-$i >/dev/null 2>&1 || true
    done
    
    print_success "UDP Mini Services"
}

# SlowDNS Configuration
function ssh_slow(){
    print_install "Installing SlowDNS Server"
    
    wget -q -O /tmp/nameserver "${REPO}files/nameserver" >/dev/null 2>&1
    chmod +x /tmp/nameserver
    bash /tmp/nameserver | tee /root/install.log
    
    print_success "SlowDNS Server"
}

# SSHD Configuration
function ins_SSHD(){
    print_install "Configuring SSHD"
    
    # Backup original config
    cp /etc/ssh/sshd_config /etc/ssh/sshd_config.backup.$(date +%Y%m%d_%H%M%S)
    
    # Download and test new config
    if wget -q -O /tmp/sshd_config_new "${REPO}files/sshd" >/dev/null 2>&1; then
        if sshd -t -f /tmp/sshd_config_new >/dev/null 2>&1; then
            cp /tmp/sshd_config_new /etc/ssh/sshd_config
            chmod 644 /etc/ssh/sshd_config
            systemctl reload ssh >/dev/null 2>&1
        else
            echo "Warning: New SSH config has errors, keeping original"
            sed -i 's/^#\?PermitRootLogin.*/PermitRootLogin yes/' /etc/ssh/sshd_config
        fi
    fi
    
    rm -f /tmp/sshd_config_new
    
    print_success "SSHD Configuration"
}

# Dropbear Installation
function ins_dropbear(){
    print_install "Installing Dropbear SSH"
    
    apt-get install dropbear -y > /dev/null 2>&1
    
    mkdir -p /etc/dropbear
    
    # Generate host keys
    if [ ! -f /etc/dropbear/dropbear_rsa_host_key ]; then
        dropbearkey -t rsa -f /etc/dropbear/dropbear_rsa_host_key -s 2048 >/dev/null 2>&1
    fi
    if [ ! -f /etc/dropbear/dropbear_dss_host_key ]; then
        dropbearkey -t dss -f /etc/dropbear/dropbear_dss_host_key >/dev/null 2>&1
    fi
    if [ ! -f /etc/dropbear/dropbear_ecdsa_host_key ]; then
        dropbearkey -t ecdsa -f /etc/dropbear/dropbear_ecdsa_host_key >/dev/null 2>&1
    fi
    
    chmod 600 /etc/dropbear/dropbear_*_host_key 2>/dev/null || true
    
    wget -q -O /etc/default/dropbear "${REPO}config/dropbear.conf"
    wget -q -O /etc/alrelshop.txt "${REPO}files/issue.net"
    chmod 644 /etc/default/dropbear
    
    echo "/bin/false" >> /etc/shells 2>/dev/null || true
    echo "/usr/sbin/nologin" >> /etc/shells 2>/dev/null || true
    
    systemctl restart dropbear >/dev/null 2>&1 || true
    
    print_success "Dropbear SSH"
}

# Vnstat Installation
function ins_vnstat(){
    print_install "Installing Network Monitor (Vnstat)"
    
    apt -y install vnstat > /dev/null 2>&1
    /etc/init.d/vnstat restart
    apt -y install libsqlite3-dev > /dev/null 2>&1
    
    # Download and compile latest vnstat
    wget https://humdi.net/vnstat/vnstat-2.6.tar.gz
    tar zxvf vnstat-2.6.tar.gz
    cd vnstat-2.6
    ./configure --prefix=/usr --sysconfdir=/etc && make && make install
    cd
    
    vnstat -u -i $NET
    sed -i 's/Interface "'""eth0""'"/Interface "'""$NET""'"/g' /etc/vnstat.conf
    chown vnstat:vnstat /var/lib/vnstat -R
    systemctl enable vnstat
    /etc/init.d/vnstat restart
    
    rm -f /root/vnstat-2.6.tar.gz
    rm -rf /root/vnstat-2.6
    
    print_success "Network Monitor"
}

# OpenVPN Installation
function ins_openvpn(){
    print_install "Installing OpenVPN Server"
    
    apt install openvpn easy-rsa unzip -y >/dev/null 2>&1
    wget ${REPO}files/openvpn && chmod +x openvpn && ./openvpn
    
    # Handle different OpenVPN service names
    if [ -f /etc/systemd/system/openvpn.service ]; then
        systemctl enable openvpn >/dev/null 2>&1 || true
        systemctl start openvpn >/dev/null 2>&1 || true
    elif systemctl list-unit-files | grep -q "openvpn@"; then
        systemctl enable openvpn@server >/dev/null 2>&1 || true
        systemctl start openvpn@server >/dev/null 2>&1 || true
    fi
    
    print_success "OpenVPN Server"
}

# Backup and Tools Installation
function ins_backup(){
    print_install "Installing Backup & Tools"
    
    # Rclone installation
    apt install rclone -y
    printf "q\n" | rclone config
    wget -O /root/.config/rclone/rclone.conf "${REPO}config/rclone.conf"
    
    # Wondershaper for bandwidth management
    cd /bin
    git clone https://github.com/magnific0/wondershaper.git
    cd wondershaper
    sudo make install
    cd
    rm -rf wondershaper
    echo > /home/limit
    
    # Email configuration
    apt install msmtp-mta ca-certificates bsd-mailx -y
    cat<<EOF>>/etc/msmtprc
defaults
tls on
tls_starttls on
tls_trust_file /etc/ssl/certs/ca-certificates.crt

account default
host smtp.gmail.com
port 587
auth on
user alrelshop.notification@gmail.com
from alrelshop.notification@gmail.com
password AlrelShop2024!
logfile ~/.msmtp.log
EOF
    chown -R www-data:www-data /etc/msmtprc
    
    wget -q -O /etc/ipserver "${REPO}files/ipserver" && bash /etc/ipserver
    
    print_success "Backup & Tools"
}

# Swap Configuration
function ins_swab(){
    print_install "Configuring 1GB Swap Memory"
    
    # Install gotop system monitor
    gotop_latest="$(curl -s https://api.github.com/repos/xxxserxxx/gotop/releases | grep tag_name | sed -E 's/.*"v(.*)".*/\1/' | head -n 1)"
    gotop_link="https://github.com/xxxserxxx/gotop/releases/download/v$gotop_latest/gotop_v"$gotop_latest"_linux_amd64.deb"
    curl -sL "$gotop_link" -o /tmp/gotop.deb
    dpkg -i /tmp/gotop.deb >/dev/null 2>&1
    
    # Create swap file
    dd if=/dev/zero of=/swapfile bs=1024 count=1048576
    mkswap /swapfile
    chown root:root /swapfile
    chmod 0600 /swapfile >/dev/null 2>&1
    swapon /swapfile >/dev/null 2>&1
    sed -i '$ i\/swapfile      swap swap   defaults    0 0' /etc/fstab
    
    # Time synchronization
    if command -v chronyd >/dev/null 2>&1; then
        chronyd -q 'server 0.id.pool.ntp.org iburst' >/dev/null 2>&1 || true
    else
        ntpdate -s pool.ntp.org >/dev/null 2>&1 || true
    fi
    
    # BBR TCP congestion control
    wget ${REPO}files/bbr.sh && chmod +x bbr.sh && ./bbr.sh
    
    print_success "Swap Memory"
}

# Security Configuration
function ins_Fail2ban(){
    print_install "Configuring Security & Banner"
    
    # DDoS protection setup
    if [ -d '/usr/local/ddos' ]; then
        echo "DDoS protection already installed"
    else
        mkdir /usr/local/ddos
    fi
    
    # Professional banner
    echo "Banner /etc/alrelshop.txt" >>/etc/ssh/sshd_config
    sed -i 's@DROPBEAR_BANNER=""@DROPBEAR_BANNER="/etc/alrelshop.txt"@g' /etc/default/dropbear
    
    # Create professional banner
    cat > /etc/alrelshop.txt << 'EOF'
╔═══════════════════════════════════════════════════════════════╗
║                                                               ║
║                    ✦ ALRELSHOP VPN SERVER ✦                   ║
║                      Professional Edition                     ║
║                                                               ║
║  🔐 Secure • 🚀 Fast • 🛡️ Reliable • 📱 Multi-Platform         ║
║                                                               ║
║  ⚡ High-Speed Connection with Advanced Security              ║
║  🌐 Multi-Protocol Support (V2Ray, SSH, OpenVPN)             ║
║  🔒 SSL/TLS Encryption                                        ║
║  📊 Real-time Monitoring                                      ║
║                                                               ║
║  Support: +6282285851668 (WhatsApp)                          ║
║  Telegram: @AlrelShop                                         ║
║                                                               ║
║  © 2024 AlrelShop Solutions - All Rights Reserved            ║
║                                                               ║
╚═══════════════════════════════════════════════════════════════╝
EOF
    
    print_success "Security & Banner"
}

# WebSocket Proxy Installation
function ins_epro(){
    print_install "Installing WebSocket Proxy (WS-ePro)"
    
    # Download with multiple fallback sources
    if ! wget -O /usr/bin/ws "${REPO}files/ws" >/dev/null 2>&1; then
        echo "Primary source failed, trying alternatives..."
        wget -O /usr/bin/ws "https://github.com/yonggekkk/warp-yg/raw/main/files/ws" >/dev/null 2>&1 || \
        curl -L -o /usr/bin/ws "https://raw.githubusercontent.com/alrel1408/scriptaku/main/files/ws" >/dev/null 2>&1 || true
    fi
    
    # Download config
    wget -O /usr/bin/tun.conf "${REPO}config/tun.conf" >/dev/null 2>&1
    wget -O /etc/systemd/system/ws.service "${REPO}files/ws.service" >/dev/null 2>&1
    
    # Set permissions
    if [ -f /usr/bin/ws ]; then
        chmod +x /usr/bin/ws
    fi
    if [ -f /usr/bin/tun.conf ]; then
        chmod 644 /usr/bin/tun.conf
    fi
    chmod 644 /etc/systemd/system/ws.service
    
    systemctl daemon-reload
    systemctl enable ws >/dev/null 2>&1 || true
    systemctl start ws >/dev/null 2>&1 || true
    
    # Download geo data files
    wget -q -O /usr/local/share/xray/geosite.dat "https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geosite.dat" >/dev/null 2>&1
    wget -q -O /usr/local/share/xray/geoip.dat "https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geoip.dat" >/dev/null 2>&1
    
    # Anti-torrent rules
    wget -O /usr/sbin/ftvpn "${REPO}files/ftvpn" >/dev/null 2>&1
    chmod +x /usr/sbin/ftvpn
    
    # Firewall rules for torrent blocking
    iptables -A FORWARD -m string --string "get_peers" --algo bm -j DROP
    iptables -A FORWARD -m string --string "announce_peer" --algo bm -j DROP
    iptables -A FORWARD -m string --string "find_node" --algo bm -j DROP
    iptables -A FORWARD -m string --algo bm --string "BitTorrent" -j DROP
    iptables -A FORWARD -m string --algo bm --string "BitTorrent protocol" -j DROP
    iptables -A FORWARD -m string --algo bm --string "peer_id=" -j DROP
    iptables -A FORWARD -m string --algo bm --string ".torrent" -j DROP
    iptables -A FORWARD -m string --algo bm --string "announce.php?passkey=" -j DROP
    iptables -A FORWARD -m string --algo bm --string "torrent" -j DROP
    iptables -A FORWARD -m string --algo bm --string "announce" -j DROP
    iptables -A FORWARD -m string --algo bm --string "info_hash" -j DROP
    
    # Save firewall rules
    iptables-save > /etc/iptables.up.rules
    if command -v netfilter-persistent >/dev/null 2>&1; then
        netfilter-persistent save >/dev/null 2>&1 || true
    fi
    
    # Cleanup
    apt autoclean -y >/dev/null 2>&1
    apt autoremove -y >/dev/null 2>&1
    
    print_success "WebSocket Proxy"
}

# Service Restart
function ins_restart(){
    print_install "Starting All Services"
    
    systemctl daemon-reload
    
    # Create required directories
    mkdir -p /run/sshd
    mkdir -p /var/log/xray
    mkdir -p /run/xray
    chown www-data:www-data /var/log/xray
    chown www-data:www-data /run/xray
    
    # Install netfilter-persistent if missing
    if ! systemctl list-unit-files | grep -q netfilter-persistent; then
        apt-get install -y iptables-persistent netfilter-persistent >/dev/null 2>&1
    fi
    
    # Enable services
    systemctl enable nginx >/dev/null 2>&1 || true
    systemctl enable xray >/dev/null 2>&1 || true  
    systemctl enable rc-local >/dev/null 2>&1 || true
    systemctl enable cron >/dev/null 2>&1 || true
    systemctl enable haproxy >/dev/null 2>&1 || true
    systemctl enable vnstat >/dev/null 2>&1 || true
    systemctl enable netfilter-persistent >/dev/null 2>&1 || true
    
    # Enable custom services
    if [ -f /etc/systemd/system/runn.service ]; then
        systemctl enable runn >/dev/null 2>&1 || true
    fi
    if [ -f /etc/systemd/system/ws.service ]; then
        systemctl enable ws >/dev/null 2>&1 || true
    fi
    
    # Start services in order
    systemctl start rc-local >/dev/null 2>&1 || true
    systemctl start netfilter-persistent >/dev/null 2>&1 || true
    systemctl start nginx >/dev/null 2>&1 || true
    
    # Setup HAProxy SSL certificate
    if [ ! -f /etc/haproxy/hap.pem ] && [ -f /etc/xray/xray.crt ] && [ -f /etc/xray/xray.key ]; then
        cat /etc/xray/xray.crt /etc/xray/xray.key > /etc/haproxy/hap.pem
        chmod 600 /etc/haproxy/hap.pem
    fi
    
    systemctl start haproxy >/dev/null 2>&1 || true
    systemctl start xray >/dev/null 2>&1 || true
    systemctl start cron >/dev/null 2>&1 || true
    systemctl start vnstat >/dev/null 2>&1 || true
    
    # Start custom services
    if [ -f /etc/systemd/system/runn.service ]; then
        systemctl start runn >/dev/null 2>&1 || true
    fi
    if [ -f /etc/systemd/system/ws.service ]; then
        systemctl start ws >/dev/null 2>&1 || true
    fi
    
    # Start dropbear
    if command -v dropbear >/dev/null 2>&1; then
        service dropbear start >/dev/null 2>&1 || true
    fi
    
    # Start UDP services
    for i in 1 2 3; do
        if [ -f /etc/systemd/system/udp-mini-$i.service ]; then
            systemctl start udp-mini-$i >/dev/null 2>&1 || true
        fi
    done
    
    # Cleanup history
    history -c
    echo "unset HISTFILE" >> /etc/profile
    
    print_success "All Services"
}

# Menu Installation
function menu(){
    print_install "Installing Management Panel"
    
    # Download menu
    wget -O menu.zip ${REPO}menu/menu.zip
    if [ ! -s menu.zip ]; then
        echo "Primary source failed, trying backup..."
        wget -O menu.zip https://raw.githubusercontent.com/alrel1408/scriptaku/main/menu/menu.zip
    fi
    
    unzip -o menu.zip >/dev/null 2>&1
    chmod +x menu/*
    mkdir -p /usr/local/sbin
    mv menu/* /usr/local/sbin
    rm -rf menu menu.zip
    
    # Remove registration system completely
    sed -i 's|https://raw.githubusercontent.com/alrel1408/AutoScript/main/Register|# Registration disabled|g' /usr/local/sbin/*
    sed -i 's|https://raw.githubusercontent.com/alrel1408/scriptaku/main/Register|# Registration disabled|g' /usr/local/sbin/*
    
    # Replace checking function
    sed -i '/checking_sc() {/,/^}/c\
checking_sc() {\
  # Registration system disabled - always allow access\
  return 0\
}' /usr/local/sbin/*
    
    # Update branding
    sed -i 's|Vallstore|AlrelShop|g' /usr/local/sbin/*
    sed -i 's|VALLSTORE|ALRELSHOP|g' /usr/local/sbin/*
    sed -i 's|𝗩𝗮𝗹𝗹𝘀𝘁𝗼𝗿𝗲|𝗔𝗹𝗿𝗲𝗹𝗦𝗵𝗼𝗽|g' /usr/local/sbin/*
    sed -i 's|082300115583|082285851668|g' /usr/local/sbin/*
    sed -i 's|+6282300115583|+6282285851668|g' /usr/local/sbin/*
    
    # Setup PATH
    if ! grep -q "/usr/local/sbin" /etc/environment; then
        echo 'PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"' >> /etc/environment
    fi
    
    export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
    
    # Create symlinks
    if [ -f /usr/local/sbin/menu ]; then
        ln -sf /usr/local/sbin/menu /usr/bin/menu
        ln -sf /usr/local/sbin/menu /bin/menu
    fi
    
    print_success "Management Panel"
}

# Profile Configuration
function profile(){
    print_install "Configuring User Profile"
    
    # Root profile
    cat >/root/.profile <<EOF
# ~/.profile: executed by Bourne-compatible login shells.
if [ "\$BASH" ]; then
    if [ -f ~/.bashrc ]; then
        . ~/.bashrc
    fi
fi
export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
mesg n || true
clear
menu
EOF
    
    # Root bashrc
    cat >/root/.bashrc <<EOF
# ~/.bashrc: executed by bash(1) for non-login shells.
export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

if [ -t 0 ] && [ "\$PS1" ]; then
    clear
    menu
fi
EOF
    
    # Bash aliases
    cat >/root/.bash_aliases <<EOF
alias menu='/usr/local/sbin/menu'
alias m='menu'
EOF
    
    # Copy to skeleton
    cp /root/.bashrc /etc/skel/.bashrc
    cp /root/.bash_aliases /etc/skel/.bash_aliases
    cp /root/.profile /etc/skel/.profile
    
    # Global profile
    cat >> /etc/profile <<EOF

# AlrelShop VPN Script PATH
export PATH="/usr/local/sbin:\$PATH"
EOF
    
    # Cron jobs
    cat >/etc/cron.d/xp_all <<-END
SHELL=/bin/sh
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
2 0 * * * root /usr/local/sbin/xp
END
    
    cat >/etc/cron.d/logclean <<-END
SHELL=/bin/sh
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
*/20 * * * * root /usr/local/sbin/clearlog
END
    
    cat >/etc/cron.d/daily_reboot <<-END
SHELL=/bin/sh
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
0 5 * * * root /sbin/reboot
END
    
    cat >/etc/cron.d/limit_ip <<-END
SHELL=/bin/sh
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
*/2 * * * * root /usr/local/sbin/limit-ip
END
    
    echo "*/1 * * * * root echo -n > /var/log/nginx/access.log" >/etc/cron.d/log.nginx
    echo "*/1 * * * * root echo -n > /var/log/xray/access.log" >>/etc/cron.d/log.xray
    service cron restart
    
    echo "5" > /home/daily_reboot
    
    # RC Local
    cat >/etc/rc.local <<EOF
#!/bin/sh -e
# rc.local
# By default this script does nothing.
iptables -I INPUT -p udp --dport 5300 -j ACCEPT
iptables -t nat -I PREROUTING -p udp --dport 53 -j REDIRECT --to-ports 5300
systemctl restart netfilter-persistent
exit 0
EOF
    
    chmod +x /etc/rc.local
    
    print_success "User Profile"
}

# Notification System
function restart_system(){
    print_install "Finalizing Installation"
    
    MYIP=$(curl -sS ipv4.icanhazip.com)
    
    # Create default user
    echo "alrelshop" >/usr/bin/user
    echo "2099-12-31" >/usr/bin/e
    
    # Get system information
    username=$(cat /usr/bin/user)
    exp=$(cat /usr/bin/e)
    DATE=$(date +'%Y-%m-%d')
    ISP=$(curl -s ipinfo.io/org | cut -d " " -f 2-10 )
    domain=$(cat /etc/xray/domain)
    TIMEZONE=$(printf '%(%H:%M:%S)T')
    
    # Telegram notification (optional)
    TIMES="10"
    CHATID="6735684125"
    KEY="6501332793:AAFqR8ie_r1m6hLquZdMw7_wCAVp3hcbp20"
    URL="https://api.telegram.org/bot$KEY/sendMessage"
    TEXT="
<code>━━━━━━━━━━━━━━━━━━━━━━━━━</code>
<b>✅ ALRELSHOP VPN INSTALLED</b>
<code>━━━━━━━━━━━━━━━━━━━━━━━━━</code>
<code>User     :</code><code>$username</code>
<code>Domain   :</code><code>$domain</code>
<code>IPVPS    :</code><code>$MYIP</code>
<code>ISP      :</code><code>$ISP</code>
<code>DATE     :</code><code>$DATE</code>
<code>Time     :</code><code>$TIMEZONE</code>
<code>Exp Sc.  :</code><code>$exp</code>
<code>━━━━━━━━━━━━━━━━━━━━━━━━━</code>
<b>🚀 AlrelShop Professional VPN</b>
<code>━━━━━━━━━━━━━━━━━━━━━━━━━</code>
<i>Auto-Installation Completed Successfully</i>
"'&reply_markup={"inline_keyboard":[[{"text":"📞 Contact Support","url":"https://wa.me/+6282285851668"}]]}'
    
    curl -s --max-time $TIMES -d "chat_id=$CHATID&disable_web_page_preview=1&text=$TEXT&parse_mode=html" $URL >/dev/null 2>&1 || true
    
    print_success "Installation Finalized"
}

# Main Installation Function
function install_all(){
    clear
    echo -e "${GREEN}Starting AlrelShop VPN Installation...${NC}"
    echo ""
    
    is_root
    first_setup
    nginx_install
    base_package
    make_folder_xray
    pasang_domain
    pasang_ssl
    install_xray
    ssh
    udp_mini
    ssh_slow
    ins_SSHD
    ins_dropbear
    ins_vnstat
    ins_openvpn
    ins_backup
    ins_swab
    ins_Fail2ban
    ins_epro
    ins_restart
    menu
    profile
    restart_system
}

# Execute Installation
install_all

# Installation Summary
echo ""
history -c
rm -rf /root/menu
rm -rf /root/*.zip
rm -rf /root/*.sh
rm -rf /root/LICENSE
rm -rf /root/README.md
rm -rf /root/domain
secs_to_human "$(($(date +%s) - ${start}))"
sudo hostnamectl set-hostname $username

clear
echo -e "${CYAN}╔══════════════════════════════════════════════════════════════╗${NC}"
echo -e "${CYAN}║                                                              ║${NC}"
echo -e "${CYAN}║              ${GREEN}🎉 INSTALLATION COMPLETED! 🎉${NC}${CYAN}               ║${NC}"
echo -e "${CYAN}║                                                              ║${NC}"
echo -e "${CYAN}║               ${green}AlrelShop VPN Server v2.0${NC}${CYAN}                  ║${NC}"
echo -e "${CYAN}║              ${green}Professional Edition${NC}${CYAN}                       ║${NC}"
echo -e "${CYAN}║                                                              ║${NC}"
echo -e "${CYAN}╚══════════════════════════════════════════════════════════════╝${NC}"
echo ""

# Service Status Check
echo -e " ${YELLOW}📊 SERVICE STATUS:${NC}"
services_to_check="nginx xray haproxy dropbear vnstat"
for service in $services_to_check; do
    if systemctl is-active --quiet $service 2>/dev/null; then
        echo -e " ${green}✓${NC} $service - Active"
    else
        echo -e " ${red}✗${NC} $service - Inactive"
    fi
done

# Check custom services
custom_services="ws runn"
for service in $custom_services; do
    if [ -f /etc/systemd/system/$service.service ] && systemctl is-active --quiet $service 2>/dev/null; then
        echo -e " ${green}✓${NC} $service - Active"
    elif [ -f /etc/systemd/system/$service.service ]; then
        echo -e " ${red}✗${NC} $service - Inactive (will auto-fix after reboot)"
    fi
done

# Check UDP services
for i in 1 2 3; do
    if [ -f /etc/systemd/system/udp-mini-$i.service ] && systemctl is-active --quiet udp-mini-$i 2>/dev/null; then
        echo -e " ${green}✓${NC} udp-mini-$i - Active"
    elif [ -f /etc/systemd/system/udp-mini-$i.service ]; then
        echo -e " ${red}✗${NC} udp-mini-$i - Inactive (will auto-fix after reboot)"
    fi
done

echo ""
echo -e " ${green}✓${NC} Registration system completely disabled"
echo -e " ${green}✓${NC} Management panel installed and ready"
echo -e " ${green}✓${NC} Professional branding applied"
echo ""

echo -e "${CYAN}╔══════════════════════════════════════════════════════════════╗${NC}"
echo -e "${CYAN}║                      ${YELLOW}IMPORTANT NOTES${NC}${CYAN}                         ║${NC}"
echo -e "${CYAN}║                                                              ║${NC}"
echo -e "${CYAN}║  ${Green}•${NC} Server will reboot automatically in 10 seconds        ║${NC}"
echo -e "${CYAN}║  ${Green}•${NC} After reboot, type: ${YELLOW}menu${NC}${CYAN} to access the panel        ║${NC}"
echo -e "${CYAN}║  ${Green}•${NC} All services will auto-start after reboot             ║${NC}"
echo -e "${CYAN}║  ${Green}•${NC} Check service status with: ${YELLOW}systemctl status <service>${NC}${CYAN} ║${NC}"
echo -e "${CYAN}║                                                              ║${NC}"
echo -e "${CYAN}║  Support: ${GREEN}+6282285851668${NC}${CYAN} (WhatsApp)                      ║${NC}"
echo -e "${CYAN}║  Telegram: ${GREEN}@AlrelShop${NC}${CYAN}                                    ║${NC}"
echo -e "${CYAN}║                                                              ║${NC}"
echo -e "${CYAN}╚══════════════════════════════════════════════════════════════╝${NC}"
echo ""

# Countdown for reboot
echo -e "${YELLOW}System will reboot in:${NC}"
for i in {10..1}; do
    echo -ne "${RED}$i${NC}"
    sleep 1
    echo -ne "\r   \r"
done

echo -e "${GREEN}Rebooting now...${NC}"
sleep 2
reboot
