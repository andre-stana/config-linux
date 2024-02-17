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
    echo "Votre gestionnaire de paquets n'est pas supporté. Vous devez désinstaller manuellement : git, zsh, wget, emacs et vscode."
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
sudo $PKG_MANAGER $REMOVE_COMMAND -y git zsh wget emacs

# Désinstaller Visual Studio Code
if [ "$PKG_MANAGER" = "apt-get" ]; then
    sudo apt-get remove code
elif [ "$PKG_MANAGER" = "dnf" ]; then
    sudo dnf remove code
elif [ "$PKG_MANAGER" = "pacman" ]; then
    sudo pacman -Rns code
fi

# Changer le shell par défaut en bash
chsh -s $(which bash)