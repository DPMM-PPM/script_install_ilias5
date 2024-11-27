#!/bin/bash

# Effacer l'écran
clear

# Afficher le message d'information
echo "Les actions suivantes vont être effectuées pour configurer MariaDB :"
echo "- Configurer query_cache_size à 32M"
echo "- Configurer innodb_buffer_pool_size à 4Go"

# Demander la confirmation de l'utilisateur
read -p "Veuillez entrer 'ok' pour continuer : " confirmation

# Vérifier la confirmation
if [ "$confirmation" != "ok" ]; then
  echo "Configuration annulée."
  exit 1
fi

# Définir les variables
mariadb_conf="/etc/mysql/mariadb.conf.d/50-server.cnf"

# Faire une copie de la version originale du fichier de configuration
sudo cp "$mariadb_conf" "$mariadb_conf.bak"

# Vérifier et modifier ou ajouter les paramètres dans le fichier de configuration
sudo sed -i '/^query_cache_size/d' "$mariadb_conf"
sudo sed -i '/^innodb_buffer_pool_size/d' "$mariadb_conf"

sudo bash -c "cat >> $mariadb_conf" <<EOF

[mysqld]
query_cache_size = 32M
innodb_buffer_pool_size = 4G
EOF

# Redémarrer le service MariaDB pour appliquer les modifications
sudo systemctl restart mariadb

# Afficher les variables de configuration
echo "Variables de configuration de MariaDB :"
echo "query_cache_size : $(mysql -u root -e "SHOW VARIABLES LIKE 'query_cache_size';" | awk 'NR==2 {print $2}')"
echo "join_buffer_size : $(mysql -u root -e "SHOW VARIABLES LIKE 'join_buffer_size';" | awk 'NR==2 {print $2}')"
echo "table_open_cache : $(mysql -u root -e "SHOW VARIABLES LIKE 'table_open_cache';" | awk 'NR==2 {print $2}')"
echo "innodb_buffer_pool_size : $(mysql -u root -e "SHOW VARIABLES LIKE 'innodb_buffer_pool_size';" | awk 'NR==2 {print $2}')"

echo "Configuration de MariaDB terminée."

# Demander à l'utilisateur s'il veut continuer vers le script 3
read -p "Voulez-vous continuer l'installation vers le script 4 (4_configure_php.sh) ? (oui/non) : " continue_installation

if [ "$continue_installation" == "oui" ]; then
  echo "Lancement du script 4 (4_configure_mariadb.sh)..."
  sudo bash 4_configure_php.sh
else
  echo "Installation arrêtée. Vous pouvez lancer le script 4 manuellement si nécessaire."
fi