#!/bin/bash

# Effacer l'écran
clear

# Afficher le message d'information
echo "Les actions suivantes vont être effectuées pour configurer PHP :"
echo "- Configurer max_execution_time à 1000"
echo "- Configurer memory_limit à 1024M"
echo "- Configurer upload_max_filesize à 1024M"
echo "- Configurer session.gc_probability à 1"
echo "- Configurer session.gc_divisor à 100"
echo "- Configurer session.gc_maxlifetime à 14400"
echo "- Configurer session.hash_function à 0"
echo "- Configurer allow_url_fopen à On"
echo "- Configurer max_input_vars à 10000"
echo "- Configurer error_reporting à E_ALL & ~E_DEPRECATED & ~E_NOTICE"
echo "- Configurer display_errors à Off"

# Demander la confirmation de l'utilisateur
read -p "Veuillez entrer 'ok' pour continuer : " confirmation

# Vérifier la confirmation
if [ "$confirmation" != "ok" ]; then
  echo "Configuration annulée."
  exit 1
fi


# Configurer les paramètres PHP
php_ini_file="/etc/php/7.1/apache2/php.ini"

# Faire une copie de la version originale du fichier php.ini
sudo cp "$php_ini_file" "$php_ini_file.bak"

# Ajouter ou modifier les paramètres PHP
sudo sed -i "s/^max_execution_time.*/max_execution_time = 1000/" "$php_ini_file"
sudo sed -i "s/^memory_limit.*/memory_limit = 1024M/" "$php_ini_file"
sudo sed -i "s/^post_max_size.*/post_max_size = 1024M/" "$php_ini_file"
sudo sed -i "s/^upload_max_filesize.*/upload_max_filesize = 1024M/" "$php_ini_file"
sudo sed -i "s/^session.gc_probability.*/session.gc_probability = 1/" "$php_ini_file"
sudo sed -i "s/^session.gc_divisor.*/session.gc_divisor = 100/" "$php_ini_file"
sudo sed -i "s/^session.gc_maxlifetime.*/session.gc_maxlifetime = 14400/" "$php_ini_file"
sudo sed -i "s/^session.hash_function.*/session.hash_function = 0/" "$php_ini_file"
sudo sed -i "s/^allow_url_fopen.*/allow_url_fopen = On/" "$php_ini_file"
sudo sed -i "s/^max_input_vars.*/max_input_vars = 10000/" "$php_ini_file"
sudo sed -i "s/^display_errors.*/display_errors = Off/" "$php_ini_file"
sudo sed -i "s/^error_reporting.*/error_reporting = E_ALL \& \~E_DEPRECATED \& \~E_NOTICE/" "$php_ini_file"

# Relancer le service Apache
sudo systemctl restart apache2


echo "Configuration PHP terminée."
echo "Décommenter si nécessaire dans le fichier /etc/php/7.1/apache2/php.ini la variable max_input_vars. "

# Demander à l'utilisateur s'il veut continuer vers le script 5
read -p "Voulez-vous continuer l'installation vers le script 5 (5_install_apcu.sh) ? (oui/non) : " continue_installation

if [ "$continue_installation" == "oui" ]; then
  echo "Lancement du script 5 (5_install_apcu.sh)..."
  sudo bash 5_install_apcu.sh
else
  echo "Installation arrêtée. Vous pouvez lancer le script 3 manuellement si nécessaire."
fi
