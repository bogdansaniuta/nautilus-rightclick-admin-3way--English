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
