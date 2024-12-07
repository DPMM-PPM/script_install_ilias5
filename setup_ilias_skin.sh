#!/bin/bash

# Effacer l'écran
clear

# Afficher le message d'information
echo "Ce script va réaliser les actions suivantes :"
echo "- Créer les répertoires nécessaires"
echo "- Dézipper le fichier ZIP 'eformarine_ng.zip' dans le répertoire approprié"
echo "- Appliquer les permissions appropriées"

# Demander la confirmation de l'utilisateur
read -p "Veuillez entrer 'ok' pour continuer : " confirmation

# Vérifier la confirmation
if [ "$confirmation" != "ok" ]; then
  echo "Opération annulée."
  exit 1
fi

# Définir les variables
base_dir="/var/www/html/ilias/Customizing/global/skin"
zip_file="skin/eformarine_ng.zip"

# Créer les répertoires nécessaires
sudo mkdir -p "$base_dir/eformarine_ng"

# Dézipper le fichier ZIP dans le répertoire approprié
if [ -f "$zip_file" ]; then
  sudo unzip "$zip_file" -d "$base_dir/eformarine_ng"
  echo "Dézippage de $zip_file terminé."
else
  echo "Le fichier $zip_file n'existe pas."
fi

# Appliquer les permissions appropriées
sudo chown -R www-data:www-data /var/www/html/ilias/Customizing

echo "Opération terminée."
