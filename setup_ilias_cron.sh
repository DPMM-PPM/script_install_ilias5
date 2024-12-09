#!/bin/bash

# Effacer l'écran
clear

# Afficher le message d'information
echo "Ce script va configurer un cron job pour exécuter le script PHP tous les jours à 02h00 du matin."

# Demander la confirmation de l'utilisateur
read -p "Veuillez entrer 'ok' pour continuer : " confirmation

# Vérifier la confirmation
if [ "$confirmation" != "ok" ]; then
  echo "Opération annulée."
  exit 1
fi

# Demander le nom de l'utilisateur cron
read -p "Veuillez entrer le nom du compte adm cronuser d'Ilias : " cron_user

# Demander le mot de passe de l'utilisateur cron
read -s -p "Veuillez entrer le mot de passe du compte cronuser d'Ilias : " cron_password
echo

# Demander le nom du ClientId
read -p "Veuillez entrer le nom du ClientId : " client_id

# Définir les variables
cron_file="/etc/cron.d/ilias_cron"
php_script="/var/www/html/ilias/cron/cron.php"
log_file="/var/www/dataout/LogCron/ilias_cron.log"

# Créer le répertoire LogCron
sudo mkdir -p /var/www/dataout/LogCron
sudo chown -R www-data:www-data /var/www/dataout/LogCron


# Ajouter la tâche cron pour l'utilisateur www-data
CRON_COMMAND="0 2 * * * php $php_script $cron_user $cron_password $client_id  >> $log_file 2>&1 EOF"
(sudo crontab -u www-data -l; echo "$CRON_COMMAND" ) | sudo crontab -u www-data -

# Vérifier que la tâche a été ajoutée
echo "Tâche cron ajoutée pour l'utilisateur www-data :"
sudo crontab -u www-data -l


