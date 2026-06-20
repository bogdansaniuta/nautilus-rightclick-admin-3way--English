#!/bin/bash
# ============================================
# Script: nautilus-admin-delete-ENGLISH.sh
# Author: For Bogdan - Zorin OS
# Date: 2026-06-20
# Description: Delete files/folders as administrator
#              Supports multiple selected files
#              Asks for password ONCE only
# ============================================

# If no arguments, exit
if [ $# -eq 0 ]; then
    zenity --error --title="❌ Error ❌" --text="No file selected." --timeout=5
    exit 1
fi

# Count selected files
TOTAL=$#

# Create list of files to show
LISTA=""
for archivo in "$@"; do
    LISTA="${LISTA}<span foreground=\"#FF6600\" weight=\"bold\">$(basename "$archivo")</span>\n<span foreground=\"#666666\">→ $(dirname "$archivo")</span>\n\n"
done

# Show confirmation dialog
zenity --question   --window-icon=""   --title="⚠️ Delete as Administrator ⚠️"   --text="<span foreground=\"#CC0000\" size=\"xx-large\" weight=\"bold\">⚠️  WARNING  ⚠️</span>
<span foreground=\"#CC0000\" size=\"large\" weight=\"bold\">━━━━━━━━━━━━━━━━━━━━━━</span>

<span foreground=\"#333333\" size=\"x-large\" weight=\"bold\">You are about to PERMANENTLY DELETE....</span>

<span foreground=\"#333333\">Total files/folders:</span> <span foreground=\"#CC0000\" size=\"x-large\" weight=\"bold\">$TOTAL</span>

<span foreground=\"#333333\">Selected files:</span>

${LISTA}
<span foreground=\"#333333\">This action</span> <span foreground=\"#CC0000\" weight=\"bold\" size=\"large\">CANNOT be undone</span><span foreground=\"#333333\">.</span>

<span foreground=\"#990000\" weight=\"bold\" size=\"large\"> Are you COMPLETELY SURE ? </span>"   --ok-label="DELETE ALL"   --cancel-label="CANCEL"   --width=550   --height=400

# If user cancels, exit
if [ $? -ne 0 ]; then
    exit 0
fi

# ============================================================
# TRICK: Create a temporary script with ALL rm commands
# and execute it with pkexec ONCE
# ============================================================

# Create temporary script
TEMP_SCRIPT=$(mktemp /tmp/nautilus-admin-delete-XXXXXX.sh)

# Write the temporary script
echo "#!/bin/bash" > "$TEMP_SCRIPT"
echo "# Temporary script to delete files" >> "$TEMP_SCRIPT"
echo "" >> "$TEMP_SCRIPT"

# Add each file to the temporary script
for archivo in "$@"; do
    # Escape single quotes in the path for security
    escaped_path=$(echo "$archivo" | sed "s/'/'\\''/g")
    echo "rm -rf '$escaped_path'" >> "$TEMP_SCRIPT"
done

# Make the temporary script executable
chmod +x "$TEMP_SCRIPT"

# Execute the temporary script WITH pkexec (asks for password ONCE)
pkexec bash "$TEMP_SCRIPT"
RESULT=$?

# Delete the temporary script (with or without success)
rm -f "$TEMP_SCRIPT"

# Show result
if [ $RESULT -eq 0 ]; then
    zenity --info         --title="✅  Deleted  ✅"         --text="<span foreground=\"#228B22\" weight=\"bold\" size=\"large\">$TOTAL files deleted successfully.</span>"         --timeout=10
else
    zenity --error         --title="❌  Error  ❌"         --text="<span foreground=\"#CC0000\" weight=\"bold\">Could not delete the files.</span>"         --timeout=15
fi
