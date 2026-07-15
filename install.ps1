# ============================================
# BLUE SWAN - PowerShell Installation Script
# Author: Ian Carter Kulani
# Version: 1.0.0
# ============================================

# Set execution policy
Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process -Force

# ANSI Colors
$RED = "`e[91m"
$GREEN = "`e[92m"
$YELLOW = "`e[93m"
$BLUE = "`e[94m"
$CYAN = "`e[96m"
$WHITE = "`e[97m"
$NC = "`e[0m"

# Banner
Write-Host @"
$RED
╔══════════════════════════════════════════════════════════════════════════════╗
║$WHITE        🦢 BLUE SWAN v1.0.0 - Ultimate Cybersecurity Platform       $RED║
╠══════════════════════════════════════════════════════════════════════════════╣
║$CYAN                                                                           $RED║
║$CYAN  • 210+ Security Commands              • 📡 Ping / Nmap / Curl / Netcat$RED║
║$CYAN  • 🔌 SSH Remote Command Execution     • 🚀 REAL Traffic Generation    $RED║
║$CYAN  • 🕷️ Nikto Web Vulnerability Scanner  • 🎣 Social Engineering Suite   $RED║
║$CYAN  • ⌨️ Advanced Keylogger (F10)         • 💥 DOS Attack Capabilities    $RED║
║$CYAN  • 📧 Spear Phishing Campaigns         • 🤖 Agent Command & Control    $RED║
║$CYAN  • 📱 Multi-Platform Bot Integration   • 💻 Web Dashboard              $RED║
║$CYAN  • 🔒 IP Management & Threat Detection  • 🌐 IP to Domain Translation   $RED║
║$CYAN  • 🏠 Domain Hosting Engine            • 📊 Graphical Reports         $RED║
║$CYAN  • 🔗 IP Blockchain Integration        • 🛡️ 10,000+ IP Monitoring      $RED║
╠══════════════════════════════════════════════════════════════════════════════╣
║$WHITE                          🎯 Installation Starting...                     $RED║
╚══════════════════════════════════════════════════════════════════════════════╝$NC
"@

Write-Host ""
Write-Host "$BLUE🔍 Checking system...$NC"

# Check Python
$pythonVersion = (Get-Command python -ErrorAction SilentlyContinue).Source
if (-not $pythonVersion) {
    Write-Host "$RED❌ Python 3 not found. Please install Python 3.11+ from python.org$NC"
    Write-Host "$YELLOW⚠️  Make sure to check 'Add Python to PATH' during installation$NC"
    Read-Host "Press Enter to exit"
    exit 1
}

$pythonVersion = python --version 2>&1 | ForEach-Object { $_ -replace "Python ", "" }
Write-Host "$GREEN✅ Python version: $pythonVersion$NC"

# Check pip
$pipVersion = (Get-Command pip -ErrorAction SilentlyContinue).Source
if (-not $pipVersion) {
    Write-Host "$RED❌ pip not found. Please install pip.$NC"
    Read-Host "Press Enter to exit"
    exit 1
}
Write-Host "$GREEN✅ pip found$NC"

# Set installation paths
$INSTALL_DIR = "$env:USERPROFILE\.blue_swan"
$VENV_DIR = "$INSTALL_DIR\venv"
$SOURCE_DIR = "$INSTALL_DIR\source"
$CONFIG_DIR = "$env:USERPROFILE\.config\blue_swan"

Write-Host "$BLUE📁 Installation directory: $INSTALL_DIR$NC"

# Create directories
if (-not (Test-Path $INSTALL_DIR)) { New-Item -ItemType Directory -Path $INSTALL_DIR -Force | Out-Null }
if (-not (Test-Path $SOURCE_DIR)) { New-Item -ItemType Directory -Path $SOURCE_DIR -Force | Out-Null }
if (-not (Test-Path $CONFIG_DIR)) { New-Item -ItemType Directory -Path $CONFIG_DIR -Force | Out-Null }

# Setup virtual environment
Write-Host "$BLUE🐍 Setting up Python virtual environment...$NC"

if (Test-Path $VENV_DIR) {
    Write-Host "$YELLOW⚠️  Virtual environment already exists. Recreating...$NC"
    Remove-Item -Recurse -Force $VENV_DIR
}

python -m venv $VENV_DIR
if ($LASTEXITCODE -ne 0) {
    Write-Host "$RED❌ Failed to create virtual environment$NC"
    Read-Host "Press Enter to exit"
    exit 1
}

Write-Host "$GREEN✅ Virtual environment created$NC"

# Activate virtual environment
& "$VENV_DIR\Scripts\Activate.ps1"

# Install Python packages
Write-Host "$BLUE📦 Installing Python packages...$NC"

# Upgrade pip
python -m pip install --upgrade pip setuptools wheel

# Install packages
$packages = @(
    "requests", "psutil", "cryptography", "dnspython", "python-whois", "paramiko",
    "Flask", "Flask-SocketIO", "Flask-CORS", "flask-socketio", "python-socketio",
    "discord.py", "slack-sdk", "telethon", "pywhatkit",
    "pynput", "pygetwindow", "pyautogui", "pyperclip",
    "matplotlib", "seaborn", "numpy", "reportlab",
    "beautifulsoup4", "lxml", "qrcode", "pyshorteners",
    "google-api-python-client", "google-auth-httplib2", "google-auth-oauthlib", "httplib2",
    "colorama", "tqdm", "python-dotenv", "PyYAML",
    "scapy"
)

foreach ($pkg in $packages) {
    Write-Host "$CYAN  Installing $pkg...$NC"
    pip install $pkg
}

if ($LASTEXITCODE -ne 0) {
    Write-Host "$RED❌ Failed to install Python packages$NC"
    Read-Host "Press Enter to exit"
    exit 1
}

Write-Host "$GREEN✅ Python packages installed$NC"

# Download application
Write-Host "$BLUE📥 Downloading BLUE SWAN...$NC"

if (Test-Path "$SOURCE_DIR\blue_swan.py") {
    Write-Host "$YELLOW⚠️  Source already exists.$NC"
} else {
    Write-Host "$CYAN  Downloading from GitHub...$NC"
    try {
        Invoke-WebRequest -Uri "https://raw.githubusercontent.com/iankulani/blue-swan/main/blue_swan.py" -OutFile "$SOURCE_DIR\blue_swan.py"
    } catch {
        Write-Host "$RED❌ Failed to download. Check internet connection.$NC"
        Read-Host "Press Enter to exit"
        exit 1
    }
}

Write-Host "$GREEN✅ Application downloaded$NC"

# Create configuration
Write-Host "$BLUE⚙️  Creating configuration...$NC"

$config = @"
{
    "version": "1.0.0",
    "auto_start": false,
    "auto_block_enabled": false,
    "auto_block_threshold": 5,
    "scan_timeout": 30,
    "report_format": "html",
    "generate_graphics": true,
    "install_path": "$($INSTALL_DIR -replace '\\', '\\\\')",
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
"@

$config | Out-File -FilePath "$CONFIG_DIR\config.json" -Encoding UTF8

Write-Host "$GREEN✅ Configuration created$NC"

# Create launcher script
Write-Host "$BLUE🔧 Creating launcher script...$NC"

$launcher = @"
@echo off
REM BLUE SWAN - Windows Launcher

set "INSTALL_DIR=$env:USERPROFILE\.blue_swan"
set "VENV_DIR=%INSTALL_DIR%\venv"
set "SOURCE_DIR=%INSTALL_DIR%\source"

call "%VENV_DIR%\Scripts\activate"
python "%SOURCE_DIR%\blue_swan.py" %*
"@

$launcher | Out-File -FilePath "$INSTALL_DIR\blue_swan.bat" -Encoding ASCII

Write-Host "$GREEN✅ Launcher script created$NC"

# Create PowerShell profile function
Write-Host "$BLUE📝 Adding function to PowerShell profile...$NC"

$profileFunction = @"
function blue_swan {
    & "$INSTALL_DIR\blue_swan.bat" @args
}
"@

# Check if profile exists, create if not
if (-not (Test-Path $PROFILE)) {
    New-Item -ItemType File -Path $PROFILE -Force | Out-Null
}

# Add function if not already present
$profileContent = Get-Content $PROFILE -Raw
if ($profileContent -notmatch "function blue_swan") {
    Add-Content $PROFILE "`n$profileFunction"
    Write-Host "$GREEN✅ Function added to PowerShell profile$NC"
} else {
    Write-Host "$YELLOW⚠️  Function already exists in profile$NC"
}

# Create desktop shortcut
Write-Host "$BLUECreating desktop shortcut...$NC"

$WshShell = New-Object -comObject WScript.Shell
$Shortcut = $WshShell.CreateShortcut("$env:USERPROFILE\Desktop\BLUE SWAN.lnk")
$Shortcut.TargetPath = "$INSTALL_DIR\blue_swan.bat"
$Shortcut.WorkingDirectory = "$INSTALL_DIR"
$Shortcut.IconLocation = "$env:USERPROFILE\Desktop\BLUE SWAN.lnk,0"
$Shortcut.Save()

Write-Host "$GREEN✅ Desktop shortcut created$NC"

# Final output
Write-Host ""
Write-Host "$GREEN══════════════════════════════════════════════════════════════════════════════$NC"
Write-Host "$WHITE                    🦢 BLUE SWAN INSTALLATION COMPLETE!                       $NC"
Write-Host "$GREEN══════════════════════════════════════════════════════════════════════════════$NC"
Write-Host ""
Write-Host "$CYAN📁 Installation Directory:$NC $INSTALL_DIR"
Write-Host "$CYAN🐍 Virtual Environment:$NC $VENV_DIR"
Write-Host "$CYAN⚙️  Configuration:$NC $CONFIG_DIR"
Write-Host ""
Write-Host "$WHITE🚀 Quick Start:$NC"
Write-Host "  $GREENblue_swan$NC              - Start interactive console"
Write-Host "  $GREENblue_swan --help$NC       - Show help"
Write-Host "  $GREENblue_swan --web$NC        - Start web dashboard only"
Write-Host ""
Write-Host "$WHITE📚 Commands:$NC"
Write-Host "  Type $GREENhelp$NC for available commands"
Write-Host "  Type $GREENstatus$NC for system status"
Write-Host "  Press $GREENF10$NC to start/stop keylogger"
Write-Host ""
Write-Host "$WHITE🌐 Web Dashboard:$NC"
Write-Host "  http://localhost:5000"
Write-Host ""
Write-Host "$WHITE📖 Documentation:$NC"
Write-Host "  https://docs.blue-swan.com"
Write-Host ""
Write-Host "$YELLOW⚠️  For authorized security testing only$NC"
Write-Host "$GREEN══════════════════════════════════════════════════════════════════════════════$NC"

Read-Host "`nPress Enter to exit"