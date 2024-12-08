#!/bin/bash

# Effacer l'écran
clear

# Afficher le message d'information
echo "##########################################################################################"
echo "# AVERTISSEMENT: Ce script installe une configuration pour un client nommé eformarine    #"
echo "# Si votre client est différent de ce nom, modifier le ClientId du fichier ilServer.ini  #"
echo "# avant d'exécuter ce script.                                                            #"
echo "##########################################################################################"
echo "Ce script va réaliser les actions suivantes :"
echo "- Créer le fichier de configuration server ilServer.ini"
echo "- Créer le répertoire d'indexation"
echo "- Créer le répertoire LogRPC"
echo "- Lancer le serveur"
echo "- Voir le status du serveur"
echo "- Lancer une indexation"
echo "- Copier le fichier ilserver dans /etc.init.d/"
echo "- Permettre l'exécution du service ilserver"
echo "- Mettre en place le démarrage automatique dsu service ilserver"
echo "- Contrôler le status"

# Demander la confirmation de l'utilisateur
read -p "Veuillez entrer 'ok' pour continuer : " confirmation

# Vérifier la confirmation
if [ "$confirmation" != "ok" ]; then
  echo "Opération annulée."
  exit 1
fi

# Création du fichier de configuration server ilServer.ini
sudo cp ilServer.ini /var/www/html/ilias/Services/WebServices/RPC/lib/

# Définir les permissions pour ilServer.ini
sudo chown www-data:www-data /var/www/html/ilias/Services/WebServices/RPC/lib/ilServer.ini
sudo chmod 664 /var/www/html/ilias/Services/WebServices/RPC/lib/ilServer.ini

# Créer le répertoire d'indexation
sudo mkdir -p /var/www/dataout/index

# Définir les permissions pour le répertoire d'indexation
sudo chown -R www-data:www-data /var/www/dataout/index

# Créer le répertoire LogRPC
sudo mkdir -p /var/www/dataout/LogRPC

# Définir les permissions pour le répertoire LogRPC
sudo chown -R www-data:www-data /var/www/dataout/LogRPC

# Lancer le serveur
java -Dfile.encoding=UTF-8 -jar /var/www/html/ilias/Services/WebServices/RPC/lib/ilServer.jar /var/www/html/ilias/Services/WebServices/RPC/lib/ilServer.ini start

# Voir le status du serveur
java -jar /var/www/html/ilias/Services/WebServices/RPC/lib/ilServer.jar /var/www/html/ilias/Services/WebServices/RPC/lib/ilServer.ini status 

# Demander à l'utilisateur s'il veut lancer une indexation
read -p "Voulez-vous lancer une indexation ? (oui/non) : " indexation
if [ "$indexation" == "oui" ]; then
  java -jar /var/www/html/ilias/Services/WebServices/RPC/lib/ilServer.jar /var/www/html/ilias/Services/WebServices/RPC/lib/ilServer.ini createIndex eformarine_0 
fi


#Création du service ilserver

# Copier le fichier ilserver.service dans /etc/init.d/
sudo cp ilserver /etc/init.d/

# Permettre l'exécution
sudo chmod 750 /etc/init.d/ilserver

# Mettre en place le démarrage automatique du serveur
# Créer le répertoire de runlevel 2
#sudo mkdir -p /etc/rc2.d

# Créer le lien symbolique permettant demarrage automatique du service au reboot serveur
sudo ln -s /etc/systemd/system/ilserver.service /etc/rc2.d/S01ilserver

# Activer le service au démarrage
sudo systemctl enable ilserver

# Recharger la configuration systemd
sudo systemctl daemon-reload

#sudo update-rc.d ilserver enable
#sudo systemctl enable ilserver.service
#sudo systemctl daemon-reload
#sudo systemctl start ilserver

# Contrôler le start et  status
sudo /etc/init.d/ilserver start
sudo /etc/init.d/ilserver status


# Afficher le message d'information
echo "- La création du service ilserver est terminé" 
echo "- Dans le menu administration/recherche contrôler la date de la derniere génération d'index"
echo "- Si besoin parametrer le serveur java dans Administration/général/server/server java"
echo "- Si besoin lancer une indextion lucene via le menu administration/paramètres généraux/tâches Cron"
