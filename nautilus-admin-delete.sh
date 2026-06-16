#!/bin/bash

FILE="$1"
FILENAME=$(basename "$FILE")

zenity --question \
  --window-icon="" \
  --title="WARNING - Delete as Administrator" \
  --text='<span foreground="#CC0000" size="xx-large" weight="bold">/!\\  WARNING  /!\\</span>

<span foreground="#CC0000" size="large" weight="bold">━━━━━━━━━━━━━━━━━━━━━━</span>

<span foreground="#333333" size="large">You are about to PERMANENTLY DELETE:</span>

<span foreground="#FF6600" size="large" weight="bold">'"$FILENAME"'</span>

<span foreground="#333333">Location:</span> <span foreground="#CC0000">'"$FILE"'</span>

<span foreground="#333333">This action</span> <span foreground="#CC0000" weight="bold" size="large">CANNOT be undone</span><span foreground="#333333">.</span>

<span foreground="#990000" weight="bold" size="large"> Are you COMPLETELY SURE ? </span>' \
  --ok-label="DELETE" \
  --cancel-label="CANCEL" \
  --width=500 \
  --height=350

if [ $? -eq 0 ]; then
    pkexec rm -f "$FILE"
    if [ $? -eq 0 ]; then
        zenity --info --title="Deleted" --text="File deleted successfully." --timeout=2
    else
        zenity --error --title="Error" --text="Could not delete the file."
    fi
else
    exit 0
fi
