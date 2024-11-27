#!/bin/bash

# Effacer l'écran
clear

# Afficher le message d'information
echo "Les actions suivantes vont être effectuées pour installer et configurer APCu :"
echo "- Installer APCu pour PHP 7.1"
echo "- Configurer les paramètres APCu"

# Demander la confirmation de l'utilisateur
read -p "Veuillez entrer 'ok' pour continuer : " confirmation

# Vérifier la confirmation
if [ "$confirmation" != "ok" ]; then
  echo "Installation annulée."
  exit 1
fi


# Mettre à jour les listes de paquets
sudo apt update

# Installer APCu pour PHP 7.1
sudo apt install -y php7.1-apcu

# Configurer les paramètres spécifiques pour APCu
apcu_ini_file="/etc/php/7.1/mods-available/apcu.ini"

# Créer le fichier de configuration pour APCu
sudo bash -c "cat > $apcu_ini_file" <<EOF
extension=apcu.so

[apc]
apc.enabled=1
apc.shm_size=256M
apc.ttl=7200
apc.mmap_file_mask=/tmp/apc.XXXXXX
EOF

# Redémarrer le service Apache pour appliquer les modifications
sudo systemctl restart apache2

# Vérifier l'installation d'APCu
php -m | grep apcu

echo "Installation et configuration d'APCu terminées."

# Demander à l'utilisateur s'il veut continuer vers le script 6
read -p "Voulez-vous continuer l'installation vers le script 6 (6_configure_apache.sh) ? (oui/non) : " continue_installation

if [ "$continue_installation" == "oui" ]; then
  echo "Lancement du script 6 (6_configure_apache.sh)..."
  sudo bash 6_configure_apache.sh
else
  echo "Installation arrêtée. Vous pouvez lancer le script 3 manuellement si nécessaire."
fi