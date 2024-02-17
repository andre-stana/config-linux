#!/bin/bash

# Déterminer le gestionnaire de paquets
if [ -x "$(command -v dnf)" ]; then
    PKG_MANAGER="dnf"
    REMOVE_COMMAND="remove"
elif [ -x "$(command -v apt-get)" ]; then
    PKG_MANAGER="apt-get"
    REMOVE_COMMAND="remove"
elif [ -x "$(command -v pacman)" ]; then
    PKG_MANAGER="pacman"
    REMOVE_COMMAND="-Rns"
else
    echo "Votre gestionnaire de paquets n'est pas supporté. Vous devez désinstaller manuellement : git, zsh et wget."
    exit 1
fi

# Supprimer les plugins zsh
rm -rf ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
rm -rf ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# Supprimer le thème
rm -f ~/.oh-my-zsh/themes/themelol.zsh-theme

# Supprimer oh-my-zsh
rm -rf ~/.oh-my-zsh

# Supprimer le fichier .zshrc
rm -f ~/.zshrc

# Désinstaller les paquets
sudo $PKG_MANAGER $REMOVE_COMMAND -y git zsh wget

# Changer le shell par défaut en bash
chsh -s $(which bash)