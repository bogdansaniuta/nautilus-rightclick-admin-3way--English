#!/bin/bash

zenity --question \
  --title="WARNING - Administrator Permissions" \
  --text=''<span foreground="#CC0000" size="xx-large" weight="bold">/!\\  WARNING  /!\\</span>''
'
<span foreground="#CC0000" size="large" weight="bold">━━━━━━━━━━━━━━━━━━━━━━</span>'
'
<span foreground="#333333" size="large">You are about to open the File Manager with</span>'
<span foreground="#FF6600" size="large" weight="bold">ADMINISTRATOR PERMISSIONS</span>'
'
<span foreground="#333333">Any file you</span> <span foreground="#CC0000" weight="bold">delete, modify, or overwrite</span>'
<span foreground="#333333">could</span> <span foreground="#CC0000" weight="bold" size="large">DAMAGE</span> <span foreground="#333333">the system or installed programs.</span>'
'
<span foreground="#990000" weight="bold" size="large"> Are you COMPLETELY SURE you want to continue? </span>' \
  --ok-label="ACCEPT" \
  --cancel-label="CANCEL" \
  --width=500 \
  --height=350

if [ $? -eq 0 ]; then
    pkexec nautilus "$@"
else
    exit 0
fi
