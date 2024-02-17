#!/bin/bash

# Installer les paquets nécessaires
sudo dnf install -y git zsh wget

# Télécharger et installer oh-my-zsh
sh -c "$(wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"

# Cloner les plugins zsh
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# Créer un nouveau thème
mkdir -p ~/.oh-my-zsh/themes
echo 'PROMPT="%{$fg_bold[magenta]%}GLACIER%{$fg_bold[yellow]%} %1~ %B»%b%{$reset_color%} "
RPS1="${return_code}"' > ~/.oh-my-zsh/themes/themelol.zsh-theme

# Supprimer le fichier .zshrc existant et en créer un nouveau
rm -f ~/.zshrc
cat << EOF > ~/.zshrc
export ZSH="$HOME/.oh-my-zsh"
export PGDATA=/opt/homebrew/var/postgres
export DYLD_LLIBRARY_PATH=/opt/homebrew/Cellar/libavif:$DYLD_LIBRARY_PATH
export PATH="$HOME/.emacs.d/bin:$PATH"
export PATH="/usr/local/bin:$PATH"
export PATH=$PATH:/opt/homebrew/Cellar/sfml/2.6.0/bin
ZSH_THEME="themelol"
plugins=(git zsh-autosuggestions zsh-syntax-highlighting web-search macos docker git screen xcode encode64 z sudo vscode)
source $ZSH/oh-my-zsh.sh
EOF

# Charger le nouveau fichier .zshrc
source ~/.zshrc