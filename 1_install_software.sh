#!/bin/bash

# Effacer l'écran
clear

# Afficher le message d'information
echo "Les logiciels suivants vont être installés :"
echo "- Apache"
echo "- PHP 7.1"
echo "- MariaDB"
echo "- Ghostscript"
echo "- OpenJDK 8"
echo "- ImageMagick"
echo "- zip"
echo "- unzip"
echo "- Node.js"
echo "- APCu"
echo "- lessc"
echo "- phantomjs"

# Demander la confirmation de l'utilisateur
read -p "Veuillez entrer 'ok' pour continuer : " confirmation

# Vérifier la confirmation
if [ "$confirmation" != "ok" ]; then
  echo "Installation annulée."
  exit 1
fi

# Mettre à jour les listes de paquets
sudo apt update

# Installer Apache 2.4
sudo apt install -y apache2

# Ajouter le dépôt pour PHP 7.1
sudo add-apt-repository -y ppa:ondrej/php
sudo apt update

# Installer PHP 7.1 et les extensions nécessaires
sudo apt install -y php7.1 php7.1-gd php7.1-xsl php7.1-mysql php7.1-curl php7.1-xmlrpc php7.1-mbstring
# libapache2-mod-php7.1

# Installer FFmpeg
sudo apt install -y ffmpeg

# Installer MimeTeX
sudo apt install -y mimetex

# Installer MariaDB 10
sudo apt install -y mariadb-server

# Installer Ghostscript
sudo apt install -y ghostscript

# Installer OpenJDK 8
sudo apt install -y openjdk-8-jdk

# Installer ImageMagick 6.8+
sudo apt install -y imagemagick

# Installer zip et unzip
sudo apt install -y zip unzip

# Installer Node.js
curl -fsSL https://deb.nodesource.com/setup_16.x | sudo -E bash -
sudo apt install -y nodejs

# Installer lessc
sudo apt install -y node-less

# Installer PhantomJS à partir du fichier tar
sudo apt-get install build-essential chrpath libssl-dev libxft-dev
sudo apt-get install libfreetype6 libfreetype6-dev
sudo apt-get install libfontconfig1 libfontconfig1-dev
sudo tar xvjf phantomjs-1.9.8-linux-x86_64.tar.bz2
sudo mv phantomjs-1.9.8-linux-x86_64 /usr/local/share
sudo ln -sf /usr/local/share/phantomjs-1.9.8-linux-x86_64/bin/phantomjs /usr/local/bin

# Vérifier l'installation de PhantomJS
phantomjs -v

# Redémarrer service Apache
sudo systemctl restart apache2

# Afficher les versions des paquets installés
echo "Versions des paquets installés :"
echo "Apache : $(apache2 -v | head -n 1)"
echo "PHP : $(php -v | head -n 1)"
echo "FFmpeg : $(ffmpeg -version | head -n 1)"
echo "MimeTeX : $(mimetex -v)"
echo "MariaDB : $(mariadb --version)"
echo "Ghostscript : $(gs --version)"
echo "OpenJDK : $(java -version 2>&1 | head -n 1)"
echo "ImageMagick : $(convert --version | head -n 1)"
echo "Node.js : $(node -v)"
echo "Installation terminée."

# Demander à l'utilisateur s'il veut continuer vers le script 2
read -p "Voulez-vous continuer l'installation vers le script 2 (2_secure_mariadb.sh) ? (oui/non) : " continue_installation

if [ "$continue_installation" == "oui" ]; then
  echo "Lancement du script 2 (2_secure_mariadb.sh)..."
  sudo bash 2_secure_mariadb.sh
else
  echo "Installation arrêtée. Vous pouvez lancer le script 2 manuellement si nécessaire."
fi
