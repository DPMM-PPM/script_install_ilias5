#!/bin/bash

# Effacer l'écran
clear

# Afficher le message d'information
echo "Ce script va réaliser les actions suivantes :"
echo "- Créer les répertoires nécessaires"
echo "- Dézipper les fichiers ZIP 'UserTakeOver.zip' et 'LfMainMenu.zip' dans le répertoire approprié"
echo "- Appliquer les permissions appropriées"

# Demander la confirmation de l'utilisateur
read -p "Veuillez entrer 'ok' pour continuer : " confirmation

# Vérifier la confirmation
if [ "$confirmation" != "ok" ]; then
  echo "Opération annulée."
  exit 1
fi

# Définir les variables
base_dir="/var/www/html/ilias/Customizing/global/plugins/Services/UIComponent/UserInterfaceHook"
zip_files=("plugins/UserTakeOver.zip" "plugins/LfMainMenu.zip")

# Créer les répertoires nécessaires
sudo mkdir -p "$base_dir"

# Dézipper les fichiers ZIP dans le répertoire approprié
for zip_file in "${zip_files[@]}"; do
  if [ -f "$zip_file" ]; then
    sudo unzip "$zip_file" -d "$base_dir"
    echo "Dézippage de $zip_file terminé."
  else
    echo "Le fichier $zip_file n'existe pas."
  fi
done

# Appliquer les permissions appropriées
sudo chown -R www-data:www-data /var/www/html/ilias/Customizing

echo "Opération terminée."
echo "Mettre à jour, installer, configurer et 
activer les plugins via le menu Administration-plugins d'Ilias"

