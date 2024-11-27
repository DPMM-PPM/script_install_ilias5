#!/bin/bash

# Effacer l'écran
clear

# Afficher le message d'information
echo "Les actions suivantes vont être effectuées pour sécuriser MariaDB :"
echo "- Configurer le mot de passe root"
echo "- Supprimer les utilisateurs anonymes"
echo "- Désactiver l'accès root à distance"
echo "- Supprimer les bases de données de test"
echo "- Recharger les tables de privilèges"

# Demander la confirmation de l'utilisateur
read -p "Veuillez entrer 'ok' pour continuer : " confirmation

# Vérifier la confirmation
if [ "$confirmation" != "ok" ]; then
  echo "Sécurisation annulée."
  exit 1
fi

# Demander le mot de passe root pour MariaDB
read -s -p "Veuillez entrer le mot de passe root pour MariaDB : " root_password
echo

# Sécuriser l'installation de MariaDB
sudo mysql_secure_installation <<EOF

y
$root_password
$root_password
y
y
y
y
EOF

# Démarrer et activer MariaDB pour qu'il se lance au démarrage
sudo systemctl start mariadb
sudo systemctl enable mariadb

# Redémarrer MariaDB pour appliquer les modifications
sudo systemctl restart mariadb

echo "Sécurisation de MariaDB terminée."

# Demander à l'utilisateur s'il veut continuer vers le script 3
read -p "Voulez-vous continuer l'installation vers le script 3 (3_configure_mariadb.sh) ? (oui/non) : " continue_installation

if [ "$continue_installation" == "oui" ]; then
  echo "Lancement du script 3 (3_configure_mariadb.sh)..."
  sudo bash 3_configure_mariadb.sh
else
  echo "Installation arrêtée. Vous pouvez lancer le script 3 manuellement si nécessaire."
fi