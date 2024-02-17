#!/bin/bash

# Supprimer les plugins zsh
rm -rf ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
rm -rf ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# Supprimer le thème
rm -f ~/.oh-my-zsh/themes/themelol.zsh-theme

# Supprimer oh-my-zsh
rm -rf ~/.oh-my-zsh

# Supprimer le fichier .zshrc
rm -f ~/.zshrc

# Changer le shell par défaut en bash
chsh -s $(which bash)