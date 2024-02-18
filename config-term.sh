#!/bin/bash

# Déterminer le gestionnaire de paquets
if [ -x "$(command -v dnf)" ]; then
    PKG_MANAGER="dnf"
    INSTALL_CMD="sudo dnf install -y"
    VS_CODE_PKG="https://code.visualstudio.com/sha/download?build=stable&os=linux-rpm-x64"
elif [ -x "$(command -v apt-get)" ]; then
    PKG_MANAGER="apt-get"
    INSTALL_CMD="sudo apt-get install -y"
    VS_CODE_PKG="https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64"
elif [ -x "$(command -v pacman)" ]; then
    PKG_MANAGER="pacman -S"
    INSTALL_CMD="sudo pacman -S --noconfirm"
    VS_CODE_PKG="https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64"
else
    echo "Votre gestionnaire de paquets n'est pas supporté. Vous devez installer manuellement : git, zsh, wget, emacs et vscode."
    exit 1
fi

# Installer les paquets nécessaires
$INSTALL_CMD git zsh wget emacs

# Télécharger et installer oh-my-zsh
RUNZSH=no sh -c "$(wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"

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

# Télécharger et installer Visual Studio Code
wget -O vscode.rpm $VS_CODE_PKG
$INSTALL_CMD ./vscode.rpm

# Remplacer le shell actuel par zsh
exec zsh -l


#------config-for-epitech-student-------


clear
echo "INSTALLING PACKAGES FOR EPITECH'S DUMP"
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi
cat /etc/fedora-release | grep "Fedora release 39"
if [[ $? -ne 0 ]]; then
    echo "This script must be run onto a Fedora 39";
    exit 1
fi
echo "Press ENTER to continue..."
read

dnf upgrade -y

packages_list=(boost-devel.x86_64
               boost-static.x86_64
               ca-certificates.noarch
               clang.x86_64
               cmake.x86_64
               CUnit-devel.x86_64
               curl.x86_64
               flac-devel.x86_64
               freetype-devel.x86_64
               gcc.x86_64
               gcc-c++.x86_64
               gdb.x86_64
               git
               glibc.x86_64
               glibc-devel.x86_64
               glibc-locale-source.x86_64
               gmp-devel.x86_64
               ksh.x86_64
               elfutils-libelf-devel.x86_64
               libjpeg-turbo-devel.x86_64
               libvorbis-devel.x86_64
               SDL2.x86_64
               SDL2-static.x86_64
               SDL2-devel.x86_64
               libX11-devel.x86_64
               libXext-devel.x86_64
               ltrace.x86_64
               make.x86_64
               nasm.x86_64
               ncurses.x86_64
               ncurses-devel.x86_64
               ncurses-libs.x86_64
               net-tools.x86_64
               openal-soft-devel.x86_64
               python3-numpy.x86_64
               python3.x86_64
               rlwrap.x86_64
               ruby.x86_64
               strace.x86_64
               tar.x86_64
               tcsh.x86_64
               tmux.x86_64
               sudo.x86_64
               tree.x86_64
               unzip.x86_64
               valgrind.x86_64
               vim
               emacs-nox
               which.x86_64
               xcb-util-image.x86_64
               xcb-util-image-devel.x86_64
               zip.x86_64
               zsh.x86_64
               avr-gcc.x86_64
               qt-devel
               docker
               docker-compose
               java-17-openjdk
               java-17-openjdk-devel
               boost
               boost-math
               boost-graph
               autoconf
               automake
               tcpdump
               wireshark
               nodejs
               emacs-tuareg
               libvirt
               libvirt-devel
               virt-install
               haskell-platform
               golang
               systemd-devel
               libgudev-devel
               php.x86_64
               php-devel.x86_64
               php-bcmath.x86_64
               php-cli.x86_64
               php-gd.x86_64
               php-mbstring.x86_64
               php-mysqlnd.x86_64
               php-pdo.x86_64
               php-pear.noarch
               php-xml.x86_64
               php-gettext-gettext.noarch
               php-phar-io-version.noarch
               php-theseer-tokenizer.noarch
               SFML.x86_64
               SFML-devel.x86_64
               CSFML.x86_64
               CSFML-devel.x86_64
               irrlicht.x86_64
               irrlicht-devel.x86_64
               rust.x86_64
               cargo.x86_64
               mariadb-server.x86_64
               x264.x86_64
               lightspark.x86_64
               lightspark-mozilla-plugin.x86_64
               teams.x86_64)

dnf -y install ${packages_list[@]}

# Criterion
curl -sSL "https://github.com/Snaipe/Criterion/releases/download/v2.4.2/criterion-2.4.2-linux-x86_64.tar.xz" -o criterion-2.4.2.tar.xz
tar xf criterion-2.4.2.tar.xz
cp -r criterion-2.4.2/* /usr/local/
echo "/usr/local/lib" > /etc/ld.so.conf.d/usr-local.conf
ldconfig
rm -rf criterion-2.4.2.tar.xz criterion-2.4.2/

# Gradle
wget https://services.gradle.org/distributions/gradle-7.2-bin.zip
mkdir /opt/gradle && unzip -d /opt/gradle gradle-7.2-bin.zip && rm -f gradle-7.2-bin.zip
echo 'export PATH=$PATH:/opt/gradle/gradle-7.2/bin' >> /etc/profile

# Stack
curl -sSL https://get.haskellstack.org/ | sh

# CONFIG EMACS
git clone https://github.com/Epitech/epitech-emacs.git
cd epitech-emacs
git checkout 278bb6a630e6474f99028a8ee1a5c763e943d9a3
./INSTALL.sh system
cd .. && rm -rf epitech-emacs

# CONFIG VIM
git clone https://github.com/Epitech/vim-epitech.git
cd vim-epitech
git checkout ec936f2a49ca673901d56598e141932fd309ddac
./install.sh
cd .. && rm -rf vim-epitech


git clone git@github.com:Adri11334/epitech_any_os_dump.git

cd epitech_any_os_dump/EPITECH_STUFF/

./install <prenom.nom@epitech.eu>

sudo ./build_csfml

sudo ./install_criterion