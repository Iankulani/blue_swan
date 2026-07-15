# BLUE SWAN Dockerfile - Alpine Linux
FROM python:3.11-alpine

LABEL maintainer="Ian Carter Kulani"
LABEL version="1.0.0"
LABEL description="BLUE SWAN - Ultimate Cybersecurity Command & Control Platform"

# Install system dependencies
RUN apk update && apk add --no-cache \
    # Build tools
    gcc \
    musl-dev \
    libffi-dev \
    openssl-dev \
    python3-dev \
    # Network tools
    nmap \
    curl \
    netcat-openbsd \
    iputils \
    traceroute \
    tcpdump \
    # DNS tools
    bind-tools \
    whois \
    # SSH
    openssh-client \
    openssh-server \
    # Additional tools
    iptables \
    nikto \
    bash \
    sudo \
    vim \
    # Scapy dependencies
    libpcap-dev \
    # Cryptography dependencies
    cargo \
    # For matplotlib
    freetype-dev \
    pkgconfig \
    g++ \
    && rm -rf /var/cache/apk/*

# Create non-root user
RUN addgroup -g 1000 -S blueswan && \
    adduser -u 1000 -S blueswan -G blueswan

# Set working directory
WORKDIR /app

# Copy requirements first for better caching
COPY requirements.txt .

# Install Python packages
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt && \
    # Install additional packages not in requirements
    pip install --no-cache-dir \
    pyshark \
    pycryptodome \
    flask-limiter \
    aiohttp \
    websockets \
    uvicorn \
    gunicorn \
    gevent \
    gevent-websocket

# Copy application files
COPY blue_swan.py .
COPY blue_swan.py .
COPY .blue_swan/ .blue_swan/

# Create directories
RUN mkdir -p .blue_swan/payloads \
    .blue_swan/workspaces \
    .blue_swan/scans \
    blue_swan_reports \
    .blue_swan/phishing_pages \
    .blue_swan/phishing_templates \
    .blue_swan/captured_credentials \
    .blue_swan/ssh_keys \
    .blue_swan/traffic_logs \
    .blue_swan/nikto_results \
    .blue_swan/graphics \
    .blue_swan/web_templates \
    .blue_swan/sessions \
    .blue_swan/spear_phishing \
    .blue_swan/email_templates \
    .blue_swan/dos_logs \
    .blue_swan/agents \
    .blue_swan/c2_logs \
    .blue_swan/modules \
    .blue_swan/network_monitor \
    .blue_swan/keylog_exfil \
    .blue_swan/deployments \
    .blue_swan/domain_hosting \
    .blue_swan/blockchain \
    .blue_swan/ip_monitor

# Set permissions
RUN chown -R blueswan:blueswan /app && \
    chmod -R 755 /app

# Switch to non-root user
USER blueswan

# Expose ports
EXPOSE 5000 8080 8000-9000 22

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
    CMD python -c "import requests; requests.get('http://localhost:5000', timeout=5)" || exit 1

# Run with gunicorn for production
CMD ["gunicorn", "--worker-class", "gevent", "--workers", "4", "--bind", "0.0.0.0:5000", "blue_swan:app"]