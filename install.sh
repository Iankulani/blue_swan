
## 5. install.sh (Bash Installation Script)

```bash
#!/bin/bash
# ============================================
# BLUE SWAN - Ultimate Cybersecurity Platform
# Installation Script
# Author: Ian Carter Kulani
# Version: 1.0.0
# ============================================

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
MAGENTA='\033[0;35m'
WHITE='\033[1;37m'
NC='\033[0m' # No Color

# Variables
APP_NAME="BLUE_SWAN"
APP_VERSION="1.0.0"
INSTALL_DIR="${HOME}/.blue_swan"
BIN_DIR="/usr/local/bin"
CONFIG_DIR="${HOME}/.config/blue_swan"
REPO_URL="https://github.com/iankulani/blue-swan"
PYTHON_REQUIRED="3.11"
VENV_DIR="${INSTALL_DIR}/venv"

# ============================================
# Banner
# ============================================
print_banner() {
    echo -e "${RED}"
    echo "╔══════════════════════════════════════════════════════════════════════════════╗"
    echo "║${WHITE}        🦢 BLUE SWAN v1.0.0 - Ultimate Cybersecurity Platform       ${RED}║"
    echo "╠══════════════════════════════════════════════════════════════════════════════╣"
    echo "║${CYAN}                                                                           ${RED}║"
    echo "║${CYAN}  • 210+ Security Commands              • 📡 Ping / Nmap / Curl / Netcat${RED}║"
    echo "║${CYAN}  • 🔌 SSH Remote Command Execution     • 🚀 REAL Traffic Generation    ${RED}║"
    echo "║${CYAN}  • 🕷️ Nikto Web Vulnerability Scanner  • 🎣 Social Engineering Suite   ${RED}║"
    echo "║${CYAN}  • ⌨️ Advanced Keylogger (F10)         • 💥 DOS Attack Capabilities    ${RED}║"
    echo "║${CYAN}  • 📧 Spear Phishing Campaigns         • 🤖 Agent Command & Control    ${RED}║"
    echo "║${CYAN}  • 📱 Multi-Platform Bot Integration   • 💻 Web Dashboard              ${RED}║"
    echo "║${CYAN}  • 🔒 IP Management & Threat Detection  • 🌐 IP to Domain Translation   ${RED}║"
    echo "║${CYAN}  • 🏠 Domain Hosting Engine            • 📊 Graphical Reports         ${RED}║"
    echo "║${CYAN}  • 🔗 IP Blockchain Integration        • 🛡️ 10,000+ IP Monitoring      ${RED}║"
    echo "╠══════════════════════════════════════════════════════════════════════════════╣"
    echo "║${WHITE}                          🎯 Installation Starting...                     ${RED}║"
    echo "╚══════════════════════════════════════════════════════════════════════════════╝${NC}"
}

# ============================================
# Check System
# ============================================
check_system() {
    echo -e "${BLUE}🔍 Checking system...${NC}"
    
    # Check OS
    OS="$(uname -s)"
    case "${OS}" in
        Linux*)     OS_TYPE="Linux" ;;
        Darwin*)    OS_TYPE="macOS" ;;
        MINGW*)     OS_TYPE="Windows" ;;
        CYGWIN*)    OS_TYPE="Windows" ;;
        *)          OS_TYPE="UNKNOWN" ;;
    esac
    
    echo -e "${GREEN}✅ OS: ${OS_TYPE}${NC}"
    
    # Check Python
    if command -v python3 &> /dev/null; then
        PYTHON_VERSION=$(python3 -c "import sys; print(f'{sys.version_info.major}.{sys.version_info.minor}')")
        echo -e "${GREEN}✅ Python version: ${PYTHON_VERSION}${NC}"
        
        if [[ ! "$PYTHON_VERSION" == "$PYTHON_REQUIRED"* ]]; then
            echo -e "${YELLOW}⚠️  Recommended Python version: ${PYTHON_REQUIRED}+${NC}"
        fi
    else
        echo -e "${RED}❌ Python 3 not found. Please install Python 3.11+${NC}"
        exit 1
    fi
    
    # Check pip
    if ! command -v pip3 &> /dev/null; then
        echo -e "${RED}❌ pip3 not found. Please install pip.${NC}"
        exit 1
    fi
    
    # Check git
    if ! command -v git &> /dev/null; then
        echo -e "${YELLOW}⚠️  Git not found. Will download ZIP instead.${NC}"
    fi
    
    # Check sudo
    if command -v sudo &> /dev/null; then
        HAS_SUDO=true
    else
        HAS_SUDO=false
    fi
    
    echo -e "${GREEN}✅ System check complete${NC}"
}

# ============================================
# Install Dependencies
# ============================================
install_dependencies() {
    echo -e "${BLUE}📦 Installing system dependencies...${NC}"
    
    case "${OS_TYPE}" in
        Linux)
            if command -v apt &> /dev/null; then
                echo -e "${CYAN}Using apt package manager${NC}"
                if $HAS_SUDO; then
                    sudo apt update
                    sudo apt install -y python3-pip python3-venv nmap curl netcat-openbsd \
                        iputils-ping traceroute dnsutils whois openssh-client \
                        iptables nikto libpcap-dev build-essential libssl-dev \
                        libffi-dev python3-dev cargo
                else
                    apt update
                    apt install -y python3-pip python3-venv nmap curl netcat-openbsd \
                        iputils-ping traceroute dnsutils whois openssh-client \
                        iptables nikto libpcap-dev build-essential libssl-dev \
                        libffi-dev python3-dev cargo
                fi
            elif command -v yum &> /dev/null; then
                echo -e "${CYAN}Using yum package manager${NC}"
                if $HAS_SUDO; then
                    sudo yum install -y python3-pip python3-virtualenv nmap curl nc \
                        iputils traceroute bind-utils whois openssh-clients \
                        iptables nikto libpcap-devel gcc openssl-devel \
                        libffi-devel python3-devel cargo
                else
                    yum install -y python3-pip python3-virtualenv nmap curl nc \
                        iputils traceroute bind-utils whois openssh-clients \
                        iptables nikto libpcap-devel gcc openssl-devel \
                        libffi-devel python3-devel cargo
                fi
            elif command -v apk &> /dev/null; then
                echo -e "${CYAN}Using apk package manager (Alpine)${NC}"
                if $HAS_SUDO; then
                    sudo apk add --no-cache python3 py3-pip nmap curl netcat-openbsd \
                        iputils traceroute bind-tools whois openssh-client \
                        iptables nikto libpcap-dev build-base openssl-dev \
                        libffi-dev python3-dev cargo
                else
                    apk add --no-cache python3 py3-pip nmap curl netcat-openbsd \
                        iputils traceroute bind-tools whois openssh-client \
                        iptables nikto libpcap-dev build-base openssl-dev \
                        libffi-dev python3-dev cargo
                fi
            else
                echo -e "${YELLOW}⚠️  Unknown package manager. Please install dependencies manually.${NC}"
            fi
            ;;
        macOS)
            if command -v brew &> /dev/null; then
                echo -e "${CYAN}Using Homebrew${NC}"
                brew update
                brew install python3 nmap curl netcat traceroute bind whois openssh \
                    nikto libpcap
            else
                echo -e "${YELLOW}⚠️  Homebrew not found. Please install dependencies manually.${NC}"
            fi
            ;;
        Windows)
            echo -e "${YELLOW}⚠️  Windows detected. Please install:${NC}"
            echo "  - Python 3.11+ from python.org"
            echo "  - Nmap from nmap.org"
            echo "  - Git for Windows"
            echo "  - Visual C++ Build Tools"
            ;;
        *)
            echo -e "${YELLOW}⚠️  Unknown OS. Please install dependencies manually.${NC}"
            ;;
    esac
    
    echo -e "${GREEN}✅ System dependencies installed${NC}"
}

# ============================================
# Setup Python Environment
# ============================================
setup_venv() {
    echo -e "${BLUE}🐍 Setting up Python virtual environment...${NC}"
    
    mkdir -p "${INSTALL_DIR}"
    
    if [ -d "${VENV_DIR}" ]; then
        echo -e "${YELLOW}⚠️  Virtual environment already exists. Recreating...${NC}"
        rm -rf "${VENV_DIR}"
    fi
    
    python3 -m venv "${VENV_DIR}"
    source "${VENV_DIR}/bin/activate"
    
    # Upgrade pip
    pip install --upgrade pip setuptools wheel
    
    echo -e "${GREEN}✅ Virtual environment created${NC}"
}

# ============================================
# Install Python Packages
# ============================================
install_python_packages() {
    echo -e "${BLUE}📦 Installing Python packages...${NC}"
    
    source "${VENV_DIR}/bin/activate"
    
    # Install core packages
    pip install requests psutil cryptography dnspython python-whois paramiko
    
    # Install web framework
    pip install Flask Flask-SocketIO Flask-CORS flask-socketio python-socketio
    
    # Install platform bots
    pip install discord.py slack-sdk telethon pywhatkit
    
    # Install keylogger
    pip install pynput pygetwindow pyautogui pyperclip
    
    # Install graphics
    pip install matplotlib seaborn numpy reportlab
    
    # Install web tools
    pip install beautifulsoup4 lxml qrcode pyshorteners
    
    # Install Google APIs
    pip install google-api-python-client google-auth-httplib2 google-auth-oauthlib httplib2
    
    # Install additional utilities
    pip install colorama tqdm python-dotenv PyYAML
    
    # Install networking
    pip install scapy
    
    echo -e "${GREEN}✅ Python packages installed${NC}"
}

# ============================================
# Download Application
# ============================================
download_app() {
    echo -e "${BLUE}📥 Downloading BLUE SWAN...${NC}"
    
    if command -v git &> /dev/null; then
        if [ -d "${INSTALL_DIR}/source" ]; then
            echo -e "${YELLOW}⚠️  Source already exists. Updating...${NC}"
            cd "${INSTALL_DIR}/source"
            git pull
        else
            git clone "${REPO_URL}" "${INSTALL_DIR}/source"
        fi
    else
        # Download ZIP
        cd "${INSTALL_DIR}"
        wget -O master.zip "${REPO_URL}/archive/refs/heads/main.zip"
        unzip -o master.zip
        mv blue-swan-main source
    fi
    
    echo -e "${GREEN}✅ Application downloaded${NC}"
}

# ============================================
# Create Configuration
# ============================================
create_config() {
    echo -e "${BLUE}⚙️  Creating configuration...${NC}"
    
    mkdir -p "${CONFIG_DIR}"
    
    cat > "${CONFIG_DIR}/config.json" << EOF
{
    "version": "1.0.0",
    "auto_start": false,
    "auto_block_enabled": false,
    "auto_block_threshold": 5,
    "scan_timeout": 30,
    "report_format": "html",
    "generate_graphics": true,
    "install_path": "${INSTALL_DIR}",
    "web": {
        "enabled": true,
        "port": 5000,
        "host": "0.0.0.0",
        "require_auth": true
    },
    "keylogger": {
        "enabled": false,
        "hotkey": "f10",
        "upload_interval": 30,
        "screenshot_interval": 60,
        "exfil_methods": ["file", "email", "c2"]
    },
    "ip_monitor": {
        "enabled": true,
        "max_ips": 10000,
        "scan_interval": 300,
        "blockchain_enabled": true
    },
    "domain_hosting": {
        "enabled": true,
        "base_domain": "localhost",
        "port_range": [8000, 9000]
    }
}
EOF
    
    echo -e "${GREEN}✅ Configuration created${NC}"
}

# ============================================
# Create Entry Script
# ============================================
create_entry_script() {
    echo -e "${BLUE}🔧 Creating entry script...${NC}"
    
    cat > "${INSTALL_DIR}/blue_swan" << 'EOF'
#!/bin/bash
# BLUE SWAN - Entry Script

INSTALL_DIR="${HOME}/.blue_swan"
VENV_DIR="${INSTALL_DIR}/venv"
SOURCE_DIR="${INSTALL_DIR}/source"

source "${VENV_DIR}/bin/activate"
python "${SOURCE_DIR}/blue_swan.py" "$@"
EOF
    
    chmod +x "${INSTALL_DIR}/blue_swan"
    
    # Create symlink
    if $HAS_SUDO; then
        sudo ln -sf "${INSTALL_DIR}/blue_swan" "${BIN_DIR}/blue_swan"
    else
        echo -e "${YELLOW}⚠️  Cannot create symlink. Add ${INSTALL_DIR} to PATH manually.${NC}"
    fi
    
    echo -e "${GREEN}✅ Entry script created${NC}"
}

# ============================================
# Create Service (Systemd)
# ============================================
create_service() {
    if [ "${OS_TYPE}" = "Linux" ] && command -v systemctl &> /dev/null; then
        echo -e "${BLUE}🔧 Creating systemd service...${NC}"
        
        cat > /tmp/blue_swan.service << EOF
[Unit]
Description=BLUE SWAN Cybersecurity Platform
After=network.target

[Service]
Type=simple
User=${USER}
WorkingDirectory=${INSTALL_DIR}/source
Environment="PATH=${VENV_DIR}/bin:${PATH}"
ExecStart=${VENV_DIR}/bin/python ${INSTALL_DIR}/source/blue_swan.py
Restart=on-failure
RestartSec=10
StandardOutput=journal
StandardError=journal

[Install]
WantedBy=multi-user.target
EOF
        
        if $HAS_SUDO; then
            sudo mv /tmp/blue_swan.service /etc/systemd/system/
            sudo systemctl daemon-reload
            sudo systemctl enable blue_swan
            echo -e "${GREEN}✅ Systemd service created${NC}"
            echo -e "${CYAN}   Start with: sudo systemctl start blue_swan${NC}"
        else
            echo -e "${YELLOW}⚠️  Cannot create systemd service (requires sudo)${NC}"
        fi
    elif [ "${OS_TYPE}" = "macOS" ]; then
        echo -e "${YELLOW}ℹ️  macOS detected. Use launchd for service management.${NC}"
    fi
}

# ============================================
# Create Launch Script (Windows)
# ============================================
create_windows_launcher() {
    if [ "${OS_TYPE}" = "Windows" ]; then
        cat > "${INSTALL_DIR}/blue_swan.bat" << EOF
@echo off
REM BLUE SWAN - Windows Launcher

set INSTALL_DIR=%USERPROFILE%\.blue_swan
set VENV_DIR=%INSTALL_DIR%\venv
set SOURCE_DIR=%INSTALL_DIR%\source

call "%VENV_DIR%\Scripts\activate"
python "%SOURCE_DIR%\blue_swan.py" %*
EOF
        
        echo -e "${GREEN}✅ Windows launcher created${NC}"
        echo -e "${CYAN}   Run with: ${INSTALL_DIR}\\blue_swan.bat${NC}"
    fi
}

# ============================================
# Finalize Installation
# ============================================
finalize() {
    echo -e "${BLUE}🎉 Finalizing installation...${NC}"
    
    echo -e "${GREEN}══════════════════════════════════════════════════════════════════════════════${NC}"
    echo -e "${WHITE}                    🦢 BLUE SWAN INSTALLATION COMPLETE!                       ${NC}"
    echo -e "${GREEN}══════════════════════════════════════════════════════════════════════════════${NC}"
    echo -e ""
    echo -e "${CYAN}📁 Installation Directory:${NC} ${INSTALL_DIR}"
    echo -e "${CYAN}🐍 Virtual Environment:${NC} ${VENV_DIR}"
    echo -e "${CYAN}⚙️  Configuration:${NC} ${CONFIG_DIR}"
    echo -e ""
    echo -e "${WHITE}🚀 Quick Start:${NC}"
    echo -e "  ${GREEN}blue_swan${NC}              - Start interactive console"
    echo -e "  ${GREEN}blue_swan --help${NC}       - Show help"
    echo -e "  ${GREEN}blue_swan --web${NC}        - Start web dashboard only"
    echo -e ""
    echo -e "${WHITE}📚 Commands:${NC}"
    echo -e "  Type ${GREEN}help${NC} for available commands"
    echo -e "  Type ${GREEN}status${NC} for system status"
    echo -e "  Press ${GREEN}F10${NC} to start/stop keylogger"
    echo -e ""
    echo -e "${WHITE}🌐 Web Dashboard:${NC}"
    echo -e "  http://localhost:5000"
    echo -e ""
    echo -e "${WHITE}📖 Documentation:${NC}"
    echo -e "  https://docs.blue-swan.com"
    echo -e ""
    echo -e "${YELLOW}⚠️  For authorized security testing only${NC}"
    echo -e "${GREEN}══════════════════════════════════════════════════════════════════════════════${NC}"
}

# ============================================
# Main Installation
# ============================================
main() {
    print_banner
    
    echo -e "${BLUE}Starting installation of BLUE SWAN v${APP_VERSION}...${NC}"
    echo ""
    
    check_system
    echo ""
    
    install_dependencies
    echo ""
    
    setup_venv
    echo ""
    
    install_python_packages
    echo ""
    
    download_app
    echo ""
    
    create_config
    echo ""
    
    create_entry_script
    echo ""
    
    create_service
    echo ""
    
    create_windows_launcher
    echo ""
    
    finalize
}

# ============================================
# Run Main
# ============================================
main "$@"