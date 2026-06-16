#!/bin/bash
# Nautilus Admin Warning - Uninstaller

set -e

if [ "$EUID" -ne 0 ]; then 
    echo "⚠️  Administrator permissions required."
    echo "   Run: sudo ./uninstall.sh"
    exit 1
fi

echo "🗑️  Uninstalling Nautilus Admin Warning..."

rm -f /usr/local/bin/nautilus-admin-delete.sh
echo "   ✅ Script removed"

rm -f /usr/share/nautilus-python/extensions/nautilus-admin-custom.py
echo "   ✅ Extension removed"

if [ -f "/usr/share/nautilus-python/extensions/nautilus-admin.py.bak" ]; then
    mv /usr/share/nautilus-python/extensions/nautilus-admin.py.bak \
       /usr/share/nautilus-python/extensions/nautilus-admin.py
    echo "   ✅ Original extension restored"
fi

rm -rf /usr/share/nautilus-python/extensions/__pycache__
sudo -u "$SUDO_USER" nautilus -q 2>/dev/null || true

echo ""
echo "✅ Uninstallation complete."
