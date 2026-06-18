#!/bin/bash
# Nautilus Admin Tools - Automatic Installer
# Author: Bogdan (Zorin OS)

set -e

echo "=========================================="
echo "  Nautilus Admin Tools - Installer"
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

echo "📁 Installing scripts..."

# Open script
sudo tee /usr/local/bin/nautilus-admin-open.sh > /dev/null << 'EOF'
#!/bin/bash

FILE="$1"

if [ -d "$FILE" ]; then
    COMMAND="nautilus"
    TARGET="$FILE"
    TYPE="the File Manager"
else
    COMMAND="mousepad"
    TARGET="$FILE"
    TYPE="the Text Editor"
fi

zenity --question \
  --window-icon="" \
  --title="Open as Administrator" \
  --text='<span foreground="#CC0000" size="xx-large" weight="bold">⚠️  WARNING  ⚠️ </span>
<span foreground="#CC0000" size="large" weight="bold">━━━━━━━━━━━━━━━━━━━━━━</span>

<span foreground="#333333" size="large" weight="bold">You are about to open '"$TYPE"' with</span>

<span foreground="#CC0000" size="x-large" weight="bold">ADMINISTRATOR PERMISSIONS</span>

<span foreground="#333333" weight="bold">Location:</span> <span foreground="#CC0000" weight="bold">'"$TARGET"'</span>

<span foreground="#333333" weight="bold">You can modify, <span foreground="#0066CC" weight="bold"> Create </span> or <span foreground="#CC0000" weight="bold"> Delete </span> any system file.</span>

<span foreground="#333333" weight="bold">This action</span> <span foreground="#CC0000" weight="bold" size="large">CANNOT be undone</span><span foreground="#333333" weight="bold">.</span>

<span foreground="#990000" weight="bold" size="large"> Are you COMPLETELY SURE ? </span>' \
  --ok-label="OPEN" \
  --cancel-label="CANCEL" \
  --width=550 \
  --height=400

if [ $? -eq 0 ]; then
    sudo -E "$COMMAND" "$TARGET" 2>/dev/null
fi
EOF

chmod +x /usr/local/bin/nautilus-admin-open.sh
echo "   ✅ /usr/local/bin/nautilus-admin-open.sh"

# Delete script
sudo tee /usr/local/bin/nautilus-admin-delete.sh > /dev/null << 'EOF'
#!/bin/bash

FILE="$1"
FILENAME=$(basename "$FILE")

zenity --question \
  --window-icon="" \
  --title="⚠️ Delete as Administrator ⚠️ " \
  --text='<span foreground="#CC0000" size="xx-large" weight="bold">⚠️  WARNING  ⚠️</span>
<span foreground="#CC0000" size="large" weight="bold">━━━━━━━━━━━━━━━━━━━━━━</span>

<span foreground="#333333" size="x-large" weight="bold">You are about to PERMANENTLY DELETE:</span>

<span foreground="#FF6600" size="x-large" weight="bold">'"$FILENAME"'</span>

<span foreground="#333333">Location:</span> <span foreground="#CC0000">'"$FILE"'</span>

<span foreground="#333333">This action</span> <span foreground="#CC0000" weight="bold" size="large">CANNOT be undone</span><span foreground="#333333">.</span>

<span foreground="#990000" weight="bold" size="large"> Are you COMPLETELY SURE ? </span>' \
  --ok-label="DELETE" \
  --cancel-label="CANCEL" \
  --width=550 \
  --height=400

if [ $? -eq 0 ]; then
    pkexec rm -f "$FILE"
    if [ $? -eq 0 ]; then
        zenity --info --title="✅  Deleted  ✅" --text='<span foreground="#228B22" weight="bold">File deleted successfully.</span>' --timeout=10
    else
        zenity --error --title="❌  Error  ❌" --text='<span foreground="#CC0000" weight="bold">Could not delete the file.</span>'
    fi
else
    exit 0
fi
EOF

chmod +x /usr/local/bin/nautilus-admin-delete.sh
echo "   ✅ /usr/local/bin/nautilus-admin-delete.sh"

echo ""
echo "📁 Installing Nautilus extension..."

sudo tee /usr/share/nautilus-python/extensions/nautilus-admin-custom.py > /dev/null << 'EOF'
#!/usr/bin/env python3

from gi.repository import Nautilus, GObject
import subprocess

class AdminExtension(GObject.GObject, Nautilus.MenuProvider):

    def get_file_items(self, files):
        items = []

        # Option: Open as administrator
        item_open = Nautilus.MenuItem(
            name='AdminOpen',
            label='Open as Administrator',
            tip='Open this file with administrator permissions'
        )
        item_open.connect('activate', self.open_as_admin, files)
        items.append(item_open)

        # Option: Delete as administrator
        item_delete = Nautilus.MenuItem(
            name='AdminDelete',
            label='Delete as Administrator',
            tip='Delete this file with administrator permissions'
        )
        item_delete.connect('activate', self.delete_as_admin, files)
        items.append(item_delete)

        return items

    def get_background_items(self, current_folder):
        return []

    def open_as_admin(self, menu, files):
        for file in files:
            path = file.get_location().get_path()
            subprocess.Popen(['/usr/local/bin/nautilus-admin-open.sh', path])
            break

    def delete_as_admin(self, menu, files):
        for file in files:
            path = file.get_location().get_path()
            subprocess.Popen(['/usr/local/bin/nautilus-admin-delete.sh', path])
            break
EOF

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
echo "   2. Right-click on any file or folder"
echo "   3. Select:"
echo "      - 'Open as Administrator'"
echo "      - 'Delete as Administrator'"
echo "   4. Read the warning and confirm"
echo "   5. Enter your password if prompted"
echo ""
echo "⚠️  WARNING: Use this tool with caution."
echo "   Deleted files cannot be recovered."
echo ""
