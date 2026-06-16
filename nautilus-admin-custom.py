#!/usr/bin/env python3

from gi.repository import Nautilus, GObject
import subprocess

class AdminExtension(GObject.GObject, Nautilus.MenuProvider):

    def get_file_items(self, files):
        item = Nautilus.MenuItem(
            name='AdminOpen',
            label='Open as Administrator (with warning)',
            tip='Open this location with administrator permissions'
        )
        item.connect('activate', self.open_as_admin, files)
        return [item]

    def get_background_items(self, current_folder):
        item = Nautilus.MenuItem(
            name='AdminOpenBg',
            label='Open as Administrator (with warning)',
            tip='Open this folder with administrator permissions'
        )
        item.connect('activate', self.open_as_admin_bg, current_folder)
        return [item]

    def open_as_admin(self, menu, files):
        for file in files:
            path = file.get_location().get_path()
            subprocess.Popen(['/usr/local/bin/nautilus-admin-warning.sh', path])
            break

    def open_as_admin_bg(self, menu, current_folder):
        path = current_folder.get_location().get_path()
        subprocess.Popen(['/usr/local/bin/nautilus-admin-warning.sh', path])
