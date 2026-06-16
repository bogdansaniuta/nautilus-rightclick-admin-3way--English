# 🛡️ Nautilus Right-Click Admin (3-Way)

> Delete files as administrator directly from the right-click menu with a security warning dialog.

![Warning Window](screenshot-en.png)

## 📋 Description

**Nautilus Right-Click Admin (3-Way)** adds a "Delete as Administrator" option to the Nautilus context menu. When selected, it shows a visual warning dialog (colors, icons, bold text) before permanently deleting system files.

### ✨ Features

- 🗑️ **Delete as Administrator** directly from right-click menu
- ⚠️ **Visual warning dialog** with colors and warning icons
- 🔒 **DELETE / CANCEL buttons** to confirm the action
- 📁 **Works on any file** in the system
- 🚫 **No new window opens** — deletes directly after confirmation
- 🎨 **Attractive interface** with formatted text

## 🚀 Quick Installation

```bash
git clone https://github.com/bogdansaniuta/nautilus-rightclick-admin-3way--English.git
cd nautilus-rightclick-admin-3way--English
sudo ./install.sh
```

**Requires:** Log out and log back in (or restart) after installing.

## 📖 How to Use

1. Open the **File Manager** (Nautilus)
2. Navigate to any folder with protected files
3. **Right-click** on the file you want to delete
4. Select: **"Delete as Administrator"**
5. Read the warning and press **DELETE** or **CANCEL**
6. Enter your password if prompted
7. File is deleted directly — no new window opens!

## 🖥️ Compatibility

| Distribution | Status |
|-------------|--------|
| Zorin OS | ✅ Tested |
| Ubuntu | ✅ Compatible |
| Linux Mint | ✅ Compatible |
| Debian | ✅ Compatible |
| Pop!_OS | ✅ Compatible |

**Requirements:**
- Nautilus (GNOME Files)
- `zenity`
- `python3-nautilus`

## 🗑️ Uninstallation

```bash
sudo ./uninstall.sh
```

Then log out and log back in.

## 🎨 Customization

You can modify colors, text, and size by editing:
```bash
sudo nano /usr/local/bin/nautilus-admin-delete.sh
```

### Available Colors

| Code | Color |
|------|-------|
| `#CC0000` | Intense red |
| `#FF6600` | Orange |
| `#990000` | Dark red |
| `#333333` | Dark gray |

## 🤝 Contributing

1. Fork the repository
2. Create a branch (`git checkout -b feature/new-function`)
3. Commit your changes (`git commit -am 'Add new function'`)
4. Push to the branch (`git push origin feature/new-function`)
5. Open a Pull Request

## 📄 License

MIT License — Free to use, modify, and distribute.

## 🙏 Credits

- **Author:** Bogdan
- **System:** Zorin OS
- **Inspiration:** Windows "Run as administrator" function

---

⚠️ **WARNING:** Use this tool with caution. Deleted files cannot be recovered.
