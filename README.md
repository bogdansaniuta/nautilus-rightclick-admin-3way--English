# 🛡️ Nautilus Right-Click Admin (3-Way)

> Open and delete files as administrator directly from the right-click menu with a security warning dialog.

![Warning Window](screenshot-en.png)

## 📋 Description

**Nautilus Right-Click Admin (3-Way)** adds two options to the Nautilus context menu:
- **"Open as Administrator"** — Open files/folders with root permissions
- **"Delete as Administrator"** — Permanently delete system files

When selected, it shows a visual warning dialog (colors, icons, bold text) before executing the action.

### ✨ Features

- 📂 **Open as Administrator** — Open folders with Nautilus or files with Mousepad as root
- 🗑️ **Delete as Administrator** — Delete protected files directly from right-click menu
- ⚠️ **Visual warning dialog** with colors and warning icons
- 🔒 **Action / CANCEL buttons** to confirm
- 📁 **Works on any file or folder** in the system
- 🎨 **Attractive interface** with formatted text

## 🚀 Quick Installation

### Option 1: Download ZIP
1. Download `nautilus-rightclick-admin-3way-English.zip` from Releases
2. Extract the ZIP
3. Open terminal in the extracted folder
4. Run:

```bash
sudo ./install.sh
Option 2: Git Clone
bash
git clone https://github.com/bogdansaniuta/nautilus-rightclick-admin-3way-English.git
cd nautilus-rightclick-admin-3way-English
sudo ./install.sh
Requires: Log out and log back in (or restart Nautilus with nautilus -q) after installing.
📖 How to Use
Open the File Manager (Nautilus)
Navigate to any folder with protected files
Right-click on the file or folder
Select:
"Open as Administrator" to edit/view with root permissions
"Delete as Administrator" to permanently delete
Read the warning and press the action button or CANCEL
Enter your password if prompted
🖥️ Compatibility
Table
Distribution	Status
Zorin OS	✅ Tested
Ubuntu	✅ Compatible
Linux Mint	✅ Compatible
Debian	✅ Compatible
Pop!_OS	✅ Compatible
Requirements:
Nautilus (GNOME Files)
zenity
mousepad
python3-nautilus
🗑️ Uninstallation
bash
sudo ./uninstall.sh
Then log out and log back in (or restart Nautilus with nautilus -q).
🎨 Customization
You can modify colors, text, and size by editing:
bash
sudo nano /usr/local/bin/nautilus-admin-open.sh      # Open dialog
sudo nano /usr/local/bin/nautilus-admin-delete.sh    # Delete dialog
Available Colors
Table
Code	Color
#CC0000	Intense red
#FF6600	Orange
#0066CC	Blue
#990000	Dark red
#333333	Dark gray
🤝 Contributing
Fork the repository
Create a branch (git checkout -b feature/new-function)
Commit your changes (git commit -am 'Add new function')
Push to the branch (git push origin feature/new-function)
Open a Pull Request
📄 License
MIT License — Free to use, modify, and distribute.
🙏 Credits
Author: Bogdan
System: Zorin OS
Inspiration: Windows "Run as administrator" function
AI Assistant: 💻 🤖 💻 KIMI - AI (Artificial Intelligence) 👍
⚠️ WARNING: Use this tool with caution. Actions performed as administrator cannot be undone.
