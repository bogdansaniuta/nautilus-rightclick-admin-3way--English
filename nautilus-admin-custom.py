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
