#!/bin/sh
# PowerCAM V2 Auto-Installer Script
# Automatic detection of CPU architecture and Python version
# Auto-install without confirmation

echo "=============================================="
echo "     PowerCAM V2 Auto-Installer Script"
echo "=============================================="
echo ""
echo "Starting automatic detection and installation..."
echo ""

# Check Python version
PY_VERSION=$(python --version 2>&1 | cut -d' ' -f2 | cut -d'.' -f1)

if [ -z "$PY_VERSION" ]; then
    PY_VERSION=$(python3 --version 2>&1 | cut -d' ' -f2 | cut -d'.' -f1)
fi

if [ -z "$PY_VERSION" ]; then
    echo "ERROR: Python not found!"
    exit 1
fi

echo "✓ Detected Python version: $PY_VERSION"

# Detect CPU architecture
CPU_ARCH=$(uname -m)
echo "✓ Detected CPU architecture: $CPU_ARCH"

# Detect receiver model
if [ -f /proc/stb/info/model ]; then
    MODEL=$(cat /proc/stb/info/model)
    echo "✓ Receiver model: $MODEL"
fi

# Determine architecture and Python suffix
case "$CPU_ARCH" in
    "armv7l"|"armv6l")
        ARCH="arm"
        PY_SUFFIX=""
        [ "$PY_VERSION" = "3" ] && PY_SUFFIX="_py3"
        ;;
    "aarch64")
        ARCH="arm64"
        PY_SUFFIX=""
        [ "$PY_VERSION" = "3" ] && PY_SUFFIX="_py3"
        ;;
    "mips")
        # Check for OE 2.0
        if [ -f /etc/opkg/oe-core.conf ] || [ -f /var/lib/opkg/lists/oe-core ]; then
            ARCH="mipseloe2"
        else
            ARCH="mipsel"
        fi
        PY_SUFFIX=""
        [ "$PY_VERSION" = "3" ] && PY_SUFFIX="_py3"
        ;;
    "sh4")
        ARCH="sh4"
        PY_SUFFIX=""
        [ "$PY_VERSION" = "3" ] && PY_SUFFIX="_py3"
        ;;
    *)
        echo "✗ Unsupported CPU architecture: $CPU_ARCH"
        echo "Please install manually."
        exit 1
        ;;
esac

echo "✓ Selected installation: $ARCH (Python $PY_VERSION)"

# Installation URL
INSTALL_URL="http://files.powercam.me/powercam_v2-icam-${ARCH}${PY_SUFFIX}.sh"

echo ""
echo "📥 Downloading PowerCAM V2 for $ARCH (Python $PY_VERSION)..."
echo "🔗 URL: $INSTALL_URL"
echo ""

# Download and execute installation script
echo "🔄 Starting installation..."
echo ""

if wget --help > /dev/null 2>&1; then
    wget -q "$INSTALL_URL" -O - | /bin/sh
elif curl --help > /dev/null 2>&1; then
    curl -s "$INSTALL_URL" | /bin/sh
else
    echo "✗ ERROR: Neither wget nor curl found!"
    echo "Please install wget or curl first:"
    echo "opkg update && opkg install wget"
    exit 1
fi

INSTALL_STATUS=$?

echo ""
if [ $INSTALL_STATUS -eq 0 ]; then
    echo "=============================================="
    echo "✅ Installation completed successfully!"
    echo "=============================================="
    echo ""
    echo "🔄 Please restart your Softcam Emu with PowerCAM."
    echo ""
    echo "Restart options:"
    echo "1. Via web interface"
    echo "2. Via telnet: /etc/init.d/softcam restart"
    echo "3. Reboot your receiver: reboot"
    
    # Create restart script
    cat > /tmp/restart_cam.sh << EOF
#!/bin/sh
echo "Restarting softcam..."
/etc/init.d/softcam restart
sleep 2
echo "Softcam restarted!"
EOF
    chmod +x /tmp/restart_cam.sh
    
    echo ""
    echo "Quick restart command: /tmp/restart_cam.sh"
else
    echo "=============================================="
    echo "❌ Installation failed! Error code: $INSTALL_STATUS"
    echo "=============================================="
    echo ""
    echo "Troubleshooting tips:"
    echo "1. Check internet connection"
    echo "2. Try manual installation:"
    echo "   wget $INSTALL_URL -O - | /bin/sh"
fi

echo ""
echo "Script execution completed at: $(date)"
