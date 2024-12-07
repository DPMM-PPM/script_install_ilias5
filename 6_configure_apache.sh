#!/bin/bash

# Effacer l'écran
clear

# Afficher le message d'information
echo "Les actions suivantes vont être effectuées pour configurer Apache :"
echo "- Configurer le répertoire root du site"
echo "- Configurer le ServerName"
echo "- Créer un Virtual Host nommé eformarine.conf"

# Demander la confirmation de l'utilisateur
read -p "Veuillez entrer 'ok' pour continuer : " confirmation

# Vérifier la confirmation
if [ "$confirmation" != "ok" ]; then
  echo "Configuration annulée."
  exit 1
fi


# Définir les variables
apache_root="/var/www/html/ilias"
server_name="localhost"
vhost_file="/etc/apache2/sites-available/eformarine.conf"

# Créer le répertoire root si il n'existe pas
if [ ! -d "$apache_root" ]; then
  sudo mkdir -p "$apache_root"
fi

# Demander le ServerName
read -p "Veuillez entrer le ServerName pour Apache (par exemple, eform-marine.defense.gouv.fr) : " server_name

# Appliquer un chown www-data:www-data sur le répertoire root
sudo chown -R www-data:www-data "$apache_root"

# Créer le fichier de configuration de Virtual Host
sudo bash -c "cat > $vhost_file" <<EOF
<VirtualHost *:80>
    ServerAdmin webmaster@localhost
    ServerName $server_name
    DocumentRoot $apache_root

    <Directory $apache_root>
        Options FollowSymLinks
        AllowOverride All
        Require all granted
    </Directory>

    ErrorLog \${APACHE_LOG_DIR}/error.log
    CustomLog \${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
EOF

# Activer le site
sudo a2ensite eformarine

# Désactiver le site par défaut (si nécessaire)
sudo a2dissite 000-default

# Reload apache
sudo systemctl reload apache2

# Relancer le service Apache
sudo systemctl restart apache2

# Configurer le fichier ilias.ini.php
ilias_ini_file="ilias.ini.php"

# Remplacer les valeurs de http_path et absolute_path dans ilias.ini.php
sudo sed -i "s#^http_path =.*#http_path = \"http://$server_name\"#" "$ilias_ini_file"
sudo sed -i "s#^absolute_path =.*#absolute_path = \"$apache_root\"#" "$ilias_ini_file"

echo "Configuration d'Apache terminée."

# Demander à l'utilisateur s'il veut continuer vers le script 7
read -p "Voulez-vous continuer l'installation vers le script 7 (7_create_database.sh) ? (oui/non) : " continue_installation

if [ "$continue_installation" == "oui" ]; then
  echo "Lancement du script 7 (7_create_database.sh)..."
  sudo bash 7_create_database.sh
else
  echo "Installation arrêtée. Vous pouvez lancer le script 3 manuellement si nécessaire."
fi
