#!/bin/bash

# Effacer l'écran
clear

# Afficher le message d'information
echo "Les actions suivantes vont être effectuées pour installer ILIAS 5.3.8 :"
echo "- Télécharger ILIAS 5.3.8"
echo "- Extraire le contenu dans /var/www/html/ilias"
echo "- Configurer les permissions"
echo "- Créer le répertoire /var/www/dataout/error"
echo "- Mettre à jour le client_id dans client.ini.php et ilias.ini.php"

# Demander la confirmation de l'utilisateur
read -p "Veuillez entrer 'ok' pour continuer : " confirmation

# Vérifier la confirmation
if [ "$confirmation" != "ok" ]; then
  echo "Installation annulée."
  exit 1
fi

# Définir les variables
tar_file="ILIAS-5.3.8.tar.gz"
destination_dir="/var/www/html/ilias"
dataout_dir="/var/www/dataout"
error_dir="$dataout_dir/error"
ilias_ini_file="ilias.ini.php"
client_ini_file="client.ini.php"

# Vérifier si le fichier tar.gz existe, sinon le télécharger
if [ ! -f "$tar_file" ]; then
  echo "Le fichier $tar_file n'existe pas. Téléchargement en cours..."
  wget https://github.com/ILIAS-eLearning/ILIAS/archive/v5.3.8.tar.gz -O $tar_file
  if [ $? -ne 0 ]; then
    echo "Échec du téléchargement du fichier $tar_file."
    exit 1
  fi
fi

# Demander le nom du client ILIAS
read -p "Veuillez entrer le nom du client ILIAS (par exemple, eformemarine) : " client_name

# Créer le répertoire de destination si il n'existe pas
if [ ! -d "$destination_dir" ]; then
  sudo mkdir -p "$destination_dir"
fi

# Extraire le contenu du fichier tar.gz
sudo tar -xzf "$tar_file" -C "$destination_dir"

# Déplacer le contenu extrait dans le répertoire de destination
sudo mv "$destination_dir/ILIAS-5.3.8"/* "$destination_dir"

# Supprimer le répertoire temporaire créé par l'extraction
sudo rm -rf "$destination_dir/ILIAS-5.3.8"

# Créer le  répertoire Customizing/global/skin
sudo mkdir -p "$destination_dir/Customizing/global/skin"

# Créer le  répertoire Customizing/global/plugins
sudo mkdir -p "$destination_dir/Customizing/global/plugins"

# Appliquer les permissions appropriées
sudo chown -R www-data:www-data "$destination_dir"

# Créer le répertoire /var/www/dataout/error
if [ ! -d "$dataout_dir" ]; then
  sudo mkdir -p "$dataout_dir"
fi

if [ ! -d "$error_dir" ]; then
  sudo mkdir -p "$error_dir"
fi

# Appliquer les permissions appropriées
sudo chown -R www-data:www-data "$dataout_dir"

# Configurer le fichier ilias.ini.php
ilias_ini_file="ilias.ini.php"
client_ini_file="client.ini.php"

# Remplacer les valeurs de client dans ilias.ini.php et client.ini.php
sudo sed -i "s#^default =.*#default = \"$client_name\"#" "$ilias_ini_file"
sudo sed -i "0,/^name =.*/s#^name =.*#name = \"$client_name\"#" "$client_ini_file"

echo "Installation de ILIAS 5.3.8 et création du répertoire /var/www/dataout/ terminées."

# Afficher les informations finales
echo "À ce stade, ILIAS 5.3 est installé."
echo "Si vous avez effectué une importation d'une base de données, faites les manipulations suivantes :"
echo "  - Copiez ilias.ini.php dans /var/www/html/ilias"
echo "  - Déplacez le répertoire 'data' dans /var/www/html/ilias"
echo "  - Copiez le fichier client.ini.php dans /var/www/html/ilias/data/<nom du client>"
echo "  - Copiez le contenu du répertoire externe dans /var/www/dataout"
echo "  - Faites un chown -R www-data:www-data sur les répertoires dataout et ilias"
echo ""
echo "Si vous n'avez pas effectué une importation de base de données :"
echo "  - Vous êtes en train de créer un client ILIAS vide"
echo "  - Connectez-vous via votre navigateur à l'adresse http://<nom_server_name> et suivez les étapes indiquées."
