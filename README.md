# script_install_ilias5
Documentation Technique pour l'Installation d'ILIAS 5.3 sur Ubuntu 22.04 LTS
Cette documentation technique fournit une explication détaillée de chaque script utilisé pour l'installation d'ILIAS 5.3 sur un serveur Ubuntu 22.04 LTS. Chaque script est décrit en détail, y compris les actions qu'il effectue et les configurations qu'il applique.

#1. Installation des logiciels nécessaires (install_software.sh)
Description
Ce script installe les logiciels nécessaires pour faire fonctionner ILIAS, y compris Apache, PHP 7.1, MariaDB, Ghostscript, OpenJDK 8, ImageMagick, zip, unzip, Node.js, APCu, et lessc.

Actions effectuées
Effacer l'écran : Utilise la commande clear pour effacer l'écran.
Afficher les logiciels à installer : Liste les logiciels qui seront installés.
Demander la confirmation de l'utilisateur : Demande à l'utilisateur de taper 'ok' pour continuer.
Mettre à jour les listes de paquets : Utilise sudo apt update pour mettre à jour les listes de paquets.
Installer Apache 2.4 : Utilise sudo apt install -y apache2.
Ajouter le dépôt pour PHP 7.1 : Utilise sudo add-apt-repository -y ppa:ondrej/php et sudo apt update.
Installer PHP 7.1 et les extensions nécessaires : Utilise sudo apt install -y php7.1 php7.1-gd php7.1-xsl php7.1-mysql php7.1-curl php7.1-xmlrpc php7.1-mbstring.
Installer FFmpeg : Utilise sudo apt install -y ffmpeg.
Installer MimeTeX : Utilise sudo apt install -y mimetex.
Installer MariaDB 10 : Utilise sudo apt install -y mariadb-server.
Installer Ghostscript : Utilise sudo apt install -y ghostscript.
Installer OpenJDK 8 : Utilise sudo apt install -y openjdk-8-jdk.
Installer ImageMagick 6.8+ : Utilise sudo apt install -y imagemagick.
Installer zip et unzip : Utilise sudo apt install -y zip unzip.
Installer Node.js : Utilise curl -fsSL https://deb.nodesource.com/setup_16.x | sudo -E bash - et sudo apt install -y nodejs.
Installer lessc : Utilise sudo apt install -y node-less.
Redémarrer le service Apache : Utilise sudo systemctl restart apache2.
Afficher les versions des paquets installés : Affiche les versions des paquets installés.

#2. Sécurisation de MariaDB (secure_mariadb.sh)
Description
Ce script sécurise l'installation de MariaDB en configurant le mot de passe root, en supprimant les utilisateurs anonymes, en désactivant l'accès root à distance, en supprimant les bases de données de test, et en rechargeant les tables de privilèges.

Actions effectuées
Effacer l'écran : Utilise la commande clear.
Afficher les actions de sécurisation : Liste les actions de sécurisation qui seront effectuées.
Demander la confirmation de l'utilisateur : Demande à l'utilisateur de taper 'ok' pour continuer.
Demander le mot de passe root pour MariaDB : Demande à l'utilisateur d'entrer le mot de passe root pour MariaDB.
Sécuriser l'installation de MariaDB : Utilise sudo mysql_secure_installation avec les réponses automatisées.
Démarrer et activer MariaDB : Utilise sudo systemctl start mariadb et sudo systemctl enable mariadb.
Redémarrer MariaDB : Utilise sudo systemctl restart mariadb.

#3. Configuration de MariaDB (configure_mariadb.sh)
Description
Ce script configure les paramètres query_cache_size et innodb_buffer_pool_size de MariaDB pour optimiser les performances.

Actions effectuées
Effacer l'écran : Utilise la commande clear.
Afficher les actions de configuration : Liste les actions de configuration qui seront effectuées.
Demander la confirmation de l'utilisateur : Demande à l'utilisateur de taper 'ok' pour continuer.
Faire une copie de la version originale du fichier de configuration : Utilise sudo cp "$mariadb_conf" "$mariadb_conf.bak".
Modifier ou ajouter les paramètres dans le fichier de configuration : Utilise sudo sed pour modifier ou ajouter les paramètres.
Redémarrer le service MariaDB : Utilise sudo systemctl restart mariadb.
Afficher les variables de configuration : Affiche les variables de configuration de MariaDB.

#4. Configuration de PHP (configure_php.sh)
Description
Ce script configure les paramètres PHP tels que max_execution_time, memory_limit, upload_max_filesize, etc.

Actions effectuées
Effacer l'écran : Utilise la commande clear.
Afficher les actions de configuration : Liste les actions de configuration qui seront effectuées.
Demander la confirmation de l'utilisateur : Demande à l'utilisateur de taper 'ok' pour continuer.
Faire une copie de la version originale du fichier php.ini : Utilise sudo cp "$php_ini_file" "$php_ini_file.bak".
Modifier les paramètres PHP : Utilise sudo sed pour modifier les paramètres PHP.
Redémarrer le service Apache : Utilise sudo systemctl restart apache2.

#5. Installation et configuration d'APCu (install_apcu.sh)
Description
Ce script installe et configure APCu pour PHP 7.1.

Actions effectuées
Effacer l'écran : Utilise la commande clear.
Afficher les actions d'installation et de configuration : Liste les actions d'installation et de configuration qui seront effectuées.
Demander la confirmation de l'utilisateur : Demande à l'utilisateur de taper 'ok' pour continuer.
Mettre à jour les listes de paquets : Utilise sudo apt update.
Installer APCu pour PHP 7.1 : Utilise sudo apt install -y php7.1-apcu.
Configurer les paramètres spécifiques pour APCu : Crée le fichier de configuration pour APCu.
Redémarrer le service Apache : Utilise sudo systemctl restart apache2.
Vérifier l'installation d'APCu : Utilise php -m | grep apcu.

#6. Configuration d'Apache (configure_apache.sh)
Description
Ce script configure le répertoire root du site, le ServerName, et crée un Virtual Host nommé eformarine.conf.

Actions effectuées
Effacer l'écran : Utilise la commande clear.
Afficher les actions de configuration : Liste les actions de configuration qui seront effectuées.
Demander la confirmation de l'utilisateur : Demande à l'utilisateur de taper 'ok' pour continuer.
Créer le répertoire root si il n'existe pas : Utilise sudo mkdir -p "$apache_root".
Demander le ServerName : Demande à l'utilisateur d'entrer le ServerName pour Apache.
Appliquer un chown www-data sur le répertoire root : Utilise sudo chown -R www-data:www-data "$apache_root".
Créer le fichier de configuration de Virtual Host : Crée le fichier de configuration de Virtual Host.
Activer le site : Utilise sudo a2ensite eformarine.
Désactiver le site par défaut (si nécessaire) : Utilise sudo a2dissite 000-default.
Redémarrer le service Apache : Utilise sudo systemctl restart apache2.
Configurer le fichier ilias.ini.php : Remplace les valeurs de http_path et absolute_path dans ilias.ini.php.

#7. Création de la base de données et de l'utilisateur (create_database.sh)
Description
Ce script crée la base de données et l'utilisateur MariaDB, et configure les fichiers ilias.ini.php et client.ini.php.

Actions effectuées
Demander le nom de la base de données : Demande à l'utilisateur d'entrer le nom de la base de données.
Demander le nom de l'utilisateur : Demande à l'utilisateur d'entrer le nom de l'utilisateur.
Demander le mot de passe : Demande à l'utilisateur d'entrer le mot de passe pour l'utilisateur.
Créer la base de données : Utilise mysql -u root -e "CREATE DATABASE $db_name CHARACTER SET utf8 COLLATE utf8_general_ci;".
Créer l'utilisateur et accorder les privilèges : Utilise mysql -u root -e "CREATE USER '$user_name'@'localhost' IDENTIFIED BY '$user_password';" et mysql -u root -e "GRANT ALL PRIVILEGES ON $db_name.* TO '$user_name'@'localhost';".
Configurer le fichier ilias.ini.php : Remplace les valeurs de user, pass, et name dans ilias.ini.php et client.ini.php.
Demander si l'utilisateur veut importer un fichier .sql : Demande à l'utilisateur s'il veut importer un fichier .sql dans la base de données.
Importer le fichier .sql : Si l'utilisateur le souhaite, importe le fichier .sql dans la base de données.

#8. Installation d'ILIAS 5.3.8 (install_ilias.sh)
Description
Ce script télécharge, extrait, et configure ILIAS 5.3.8.

Actions effectuées
Effacer l'écran : Utilise la commande clear.
Afficher les actions d'installation : Liste les actions d'installation qui seront effectuées.
Demander la confirmation de l'utilisateur : Demande à l'utilisateur de taper 'ok' pour continuer.
Vérifier si le fichier tar.gz existe : Vérifie si le fichier tar.gz existe.
Demander le nom du client ILIAS : Demande à l'utilisateur d'entrer le nom du client ILIAS.
Créer le répertoire de destination si il n'existe pas : Utilise sudo mkdir -p "$destination_dir".
Extraire le contenu du fichier tar.gz : Utilise sudo tar -xzf "$tar_file" -C "$destination_dir".
Déplacer le contenu extrait dans le répertoire de destination : Utilise sudo mv "$destination_dir/ILIAS-5.3.8"/* "$destination_dir".
Supprimer le répertoire temporaire créé par l'extraction : Utilise sudo rm -rf "$destination_dir/ILIAS-5.3.8".
Appliquer les permissions appropriées : Utilise sudo chown -R www-data:www-data "$destination_dir".
Créer le répertoire /var/www/dataout/error : Utilise sudo mkdir -p "$error_dir".
Appliquer les permissions appropriées : Utilise sudo chown -R www-data:www-data "$dataout_dir".
Configurer le fichier ilias.ini.php : Remplace les valeurs de default dans ilias.ini.php et client.ini.php.

#Remarques
Assurez-vous de lire chaque script avant de l'exécuter pour comprendre les actions qui seront effectuées.
Vous pouvez personnaliser les scripts selon vos besoins spécifiques.
