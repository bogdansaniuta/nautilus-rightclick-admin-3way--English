#!/bin/bash
# Nautilus Admin Warning - Uninstaller

set -e

if [ "$EUID" -ne 0 ]; then 
    echo "⚠️  Administrator permissions required."
    echo "   Run: sudo ./uninstall.sh"
    exit 1
fi

echo "🗑️  Uninstalling Nautilus Admin Warning..."

# Remove script
rm -f /usr/local/bin/nautilus-admin-warning.sh
echo "   ✅ Script removed"

# Remove extension
rm -f /usr/share/nautilus-python/extensions/nautilus-admin-custom.py
echo "   ✅ Extension removed"

# Restore original extension if exists
if [ -f "/usr/share/nautilus-python/extensions/nautilus-admin.py.bak" ]; then
    mv /usr/share/nautilus-python/extensions/nautilus-admin.py.bak \
       /usr/share/nautilus-python/extensions/nautilus-admin.py
    echo "   ✅ Original extension restored"
fi

# Clear cache
rm -rf /usr/share/nautilus-python/extensions/__pycache__

# Restart Nautilus
sudo -u "$SUDO_USER" nautilus -q 2>/dev/null || true

echo ""
echo "✅ Uninstallation complete."
