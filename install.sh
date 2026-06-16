#!/bin/bash
# Nautilus Admin Warning - Automatic Installer
# Author: Bogdan (Zorin OS)
# Description: Delete files as administrator with security warning

set -e

echo "=========================================="
echo "  Nautilus Admin Warning - Installer"
echo "=========================================="
echo ""

if [ "$EUID" -ne 0 ]; then 
    echo "⚠️  This script requires administrator permissions."
    echo "   Run: sudo ./install.sh"
    exit 1
fi

echo "📦 Checking dependencies..."

if ! command -v zenity &> /dev/null; then
    echo "   Installing zenity..."
    apt-get update && apt-get install -y zenity
fi

if ! dpkg -l | grep -q python3-nautilus; then
    echo "   Installing python3-nautilus..."
    apt-get update && apt-get install -y python3-nautilus
fi

echo "✅ Dependencies ready."
echo ""

echo "📁 Installing delete script..."
cp nautilus-admin-delete.sh /usr/local/bin/
chmod +x /usr/local/bin/nautilus-admin-delete.sh
echo "   ✅ /usr/local/bin/nautilus-admin-delete.sh"

echo "📁 Installing Nautilus extension..."
cp nautilus-admin-custom.py /usr/share/nautilus-python/extensions/
chmod 644 /usr/share/nautilus-python/extensions/nautilus-admin-custom.py
echo "   ✅ /usr/share/nautilus-python/extensions/nautilus-admin-custom.py"

if [ -f "/usr/share/nautilus-python/extensions/nautilus-admin.py" ]; then
    echo "🗑️  Disabling original nautilus-admin extension..."
    mv /usr/share/nautilus-python/extensions/nautilus-admin.py \
       /usr/share/nautilus-python/extensions/nautilus-admin.py.bak
fi

echo "🔄 Restarting Nautilus..."
rm -rf /usr/share/nautilus-python/extensions/__pycache__
sudo -u "$SUDO_USER" nautilus -q 2>/dev/null || true

echo ""
echo "=========================================="
echo "  ✅ Installation complete!"
echo "=========================================="
echo ""
echo "📋 How to use:"
echo "   1. Open the File Manager (Nautilus)"
echo "   2. Right-click on any file"
echo "   3. Select: 'Delete as Administrator'"
echo "   4. Read the warning and choose: DELETE or CANCEL"
echo "   5. Enter your password if prompted"
echo ""
echo "⚠️  WARNING: Use this tool with caution."
echo "   Deleted files cannot be recovered."
echo ""
