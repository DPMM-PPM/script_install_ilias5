#!/bin/bash

# Effacer l'écran
clear

# Afficher le message d'information
echo "Les actions suivantes vont être effectuées pour créer la base de données et l'utilisateur :"
echo "- Demander le nom de la base de données"
echo "- Demander le nom de l'utilisateur"
echo "- Demander le mot de passe pour l'utilisateur"
echo "- Créer la base de données"
echo "- Créer l'utilisateur et accorder les privilèges"
echo "- Configurer les fichiers ilias.ini.php et client.ini.php"
echo "- Optionnellement, importer un fichier .sql dans la base de données"

# Demander la confirmation de l'utilisateur
read -p "Veuillez entrer 'ok' pour continuer : " confirmation

# Vérifier la confirmation
if [ "$confirmation" != "ok" ]; then
  echo "Création de la base de données annulée."
  exit 1
fi

# Demander le nom de la base de données
read -p "Veuillez entrer le nom de la base de données : " db_name

# Demander le nom de l'utilisateur
read -p "Veuillez entrer le nom de l'utilisateur : " user_name

# Demander le mot de passe
read -s -p "Veuillez entrer le mot de passe pour l'utilisateur : " user_password
echo

# Créer la base de données
mysql -u root -e "CREATE DATABASE $db_name CHARACTER SET utf8 COLLATE utf8_general_ci;"

# Créer l'utilisateur et accorder les privilèges
mysql -u root -e "CREATE USER '$user_name'@'localhost' IDENTIFIED BY '$user_password';"
mysql -u root -e "GRANT LOCK TABLES ON *.* TO '$user_name'@'localhost';"
mysql -u root -e "GRANT ALL PRIVILEGES ON $db_name.* TO '$user_name'@'localhost';"
mysql -u root -e "FLUSH PRIVILEGES;"

# Configurer le fichier ilias.ini.php
ilias_ini_file="ilias.ini.php"
client_ini_file="client.ini.php"


# Remplacer les valeurs de client dans ilias.ini.php et client.ini.php
sudo sed -i "s#^user =.*#user = \"$user_name\"#" "$client_ini_file"
sudo sed -i "s#^pass =.*#pass = \"$user_password\"#" "$client_ini_file"
sudo sed -i '10,${0,/^name =.*/s#^name =.*#name = "'"$db_name"'"#}' "$client_ini_file"


echo "Base de données et utilisateur créés avec succès."

# Demander si l'utilisateur veut importer un fichier .sql
read -p "Voulez-vous importer un fichier .sql dans la base de données ? (oui/non) : " import_sql

if [[ $import_sql == "oui" ]]; then
    read -p "Veuillez entrer le chemin du fichier .sql : " sql_file_path

    # Vérifier si le fichier existe
    if [[ -f $sql_file_path ]]; then
        # Importer le fichier .sql dans la base de données
        mysql -u root -e "USE $db_name; SOURCE $sql_file_path;"
        echo "Fichier .sql importé avec succès."
    else
        echo "Le fichier .sql spécifié n'existe pas."
    fi
else
    echo "Aucun fichier .sql ne sera importé."
fi

# Demander à l'utilisateur s'il veut continuer vers le script 8
read -p "Voulez-vous continuer l'installation vers le script 8 (8_install_ilias5.sh) ? (oui/non) : " continue_installation

if [ "$continue_installation" == "oui" ]; then
  echo "Lancement du script 8 (8_install_ilias5.sh)..."
  sudo bash 8_install_ilias5.sh
else
  echo "Installation arrêtée. Vous pouvez lancer le script 8 manuellement si nécessaire."
fi
