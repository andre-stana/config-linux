#!/bin/bash

# Mettre à jour et installer les paquets nécessaires
sudo dnf update -y && sudo dnf upgrade -y
sudo dnf install -y gnome-tweaks git flatpak

# Installer les extensions flatpak
flatpak install -y extensionmanager dynamicwallpaper

# Télécharger et installer les icônes Cupertino
wget https://www.gnome-look.org/p/1102582/startdownload?file_id=1531812678&file_name=Cupertino-Ventura.tar.xz&file_type=application/x-xz&file_size=2048204
tar -xf Cupertino-Ventura.tar.xz
mkdir -p ~/.icons
cp -r Cupertino-Ventura ~/.icons

# Cloner et installer le thème WhiteSur
git clone https://github.com/vinceliuice/WhiteSur-gtk-theme.git
cd WhiteSur-gtk-theme
./install.sh -t all -m -N stable -s 220 -l --normal --round
sudo ./tweaks.sh -g
sudo ./tweaks.sh -f
cd ..

# Installer les extensions GNOME
# Vous devez installer ces extensions manuellement via le navigateur, car l'installation d'extensions GNOME via la ligne de commande n'est pas officiellement supportée.

# Cloner et installer dash-to-dock
git clone https://github.com/micheleg/dash-to-dock.git
cd dash-to-dock
make
sudo make install
cd ..

# Cloner et installer dash2dock-lite
git clone https://github.com/icedman/dash2dock-lite.git
cd dash2dock-lite
make
cd ..

# Cloner et installer blur-my-shell
git clone https://github.com/aunetx/blur-my-shell.git
cd blur-my-shell
make install
cd ..