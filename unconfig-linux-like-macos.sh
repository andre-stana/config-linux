#!/bin/bash

# Désinstaller les extensions flatpak
flatpak uninstall -y extensionmanager dynamicwallpaper

# Supprimer les icônes Cupertino
rm -rf ~/.icons/Cupertino-Ventura

# Désinstaller le thème WhiteSur
cd WhiteSur-gtk-theme
./uninstall.sh
cd ..
rm -rf WhiteSur-gtk-theme

# Désinstaller les extensions GNOME
# Vous devez désinstaller ces extensions manuellement via le navigateur, car la désinstallation d'extensions GNOME via la ligne de commande n'est pas officiellement supportée.

# Désinstaller dash-to-dock
cd dash-to-dock
make uninstall
cd ..
rm -rf dash-to-dock

# Supprimer dash2dock-lite
rm -rf dash2dock-lite

# Désinstaller blur-my-shell
cd blur-my-shell
make uninstall
cd ..
rm -rf blur-my-shell

# Supprimer les paquets installés
sudo dnf remove -y gnome-tweaks git flatpak

echo "Tout est effacé !"