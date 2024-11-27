# Scripts d'installation d'ILIAS 5.3 sur Ubuntu 22.04 LTS

Ce dépôt contient une série de scripts Bash pour automatiser l'installation d'ILIAS 5.3 sur un serveur Ubuntu 22.04 LTS. Les scripts couvrent toutes les étapes nécessaires, de l'installation des logiciels requis à la configuration finale d'ILIAS.

## Prérequis

- Un serveur Ubuntu 22.04 LTS fraîchement installé.
- Accès root ou sudo.
- Connexion Internet pour télécharger les paquets nécessaires.

## Scripts

1. **install_software.sh** : Installe les logiciels nécessaires (Apache, PHP 7.1, MariaDB, etc.).
2. **secure_mariadb.sh** : Sécurise l'installation de MariaDB.
3. **configure_mariadb.sh** : Configure les paramètres de MariaDB.
4. **configure_php.sh** : Configure les paramètres PHP.
5. **install_apcu.sh** : Installe et configure APCu pour PHP 7.1.
6. **configure_apache.sh** : Configure Apache.
7. **create_database.sh** : Crée la base de données et l'utilisateur MariaDB.
8. **install_ilias.sh** : Installe ILIAS 5.3.8.

## Instructions d'utilisation

1. **Cloner le dépôt** :
   ```bash
   git clone https://github.com/vincent-sayah/script_install_ilias5.git
   cd script_install_ilias5
   ```
  

2. **Rendre les scripts exécutables** :
   ```bash
   chmod +x *.sh
   ```

3. **Exécuter les scripts dans l'ordre en tant que sudo** :

Chaque script demande une confirmation de l'utilisateur avant de procéder. Assurez-vous de lire les messages affichés par chaque script et de suivre les instructions.
Exécutez les scripts dans l'ordre suivant 

sudo bash install_software.sh
sudo bash secure_mariadb.sh
sudo bash configure_mariadb.sh
sudo bash configure_php.sh
sudo bash install_apcu.sh
sudo bash configure_apache.sh
sudo bash create_database.sh
sudo bash install_ilias.sh

Détails des scripts
1. install_software.sh
   ```bash
   sudo ./install_software.sh
   ```
Installe les logiciels nécessaires pour faire fonctionner ILIAS, y compris Apache, PHP 7.1, MariaDB, Ghostscript, OpenJDK 8, ImageMagick, zip, unzip, Node.js, APCu, et lessc.

2. secure_mariadb.sh
   ```bash
   sudo ./secure_mariadb.sh
   ```
Sécurise l'installation de MariaDB en configurant le mot de passe root, en supprimant les utilisateurs anonymes, en désactivant l'accès root à distance, en supprimant les bases de données de test, et en rechargeant les tables de privilèges.

3. configure_mariadb.sh
```bash
   sudo ./configure_mariadb.sh
   ```
Configure les paramètres query_cache_size et innodb_buffer_pool_size de MariaDB pour optimiser les performances.

4. configure_php.sh
Configure les paramètres PHP tels que max_execution_time, memory_limit, upload_max_filesize, etc.

5. install_apcu.sh
```bash
   sudo ./configure_php.sh
   ```
Installe et configure APCu pour PHP 7.1.

6. configure_apache.sh
```bash
   sudo ./configure_apache.sh
   ```
Configure le répertoire root du site, le ServerName, et crée un Virtual Host nommé eformarine.conf.

7. create_database.sh
```bash
   sudo ./create_database.sh
   ```
Crée la base de données et l'utilisateur MariaDB, et configure les fichiers ilias.ini.php et client.ini.php.

8. install_ilias5.sh
```bash
   sudo ./install_ilias5.sh
   ```
Télécharge, extrait, et configure ILIAS 5.3.8. Si le fichier ILIAS-5.3.8.tar.gz n'est pas présent dans le répertoire, il sera téléchargé automatiquement.

Informations finales
À ce stade, ILIAS 5.3 est installé.

Si vous avez effectué une importation d'une base de données :

Copiez ilias.ini.php dans /var/www/html/ilias.
Déplacez le répertoire data dans /var/www/html/ilias.
Copiez le fichier client.ini.php dans /var/www/html/ilias/data/<nom du client>.
Copiez le contenu du répertoire externe dans /var/www/dataout.
Faites un chown -R www-data:www-data sur les répertoires dataout et ilias.
Si vous n'avez pas effectué une importation de base de données :

Vous êtes en train de créer un client ILIAS vide.
Connectez-vous via votre navigateur à l'adresse http://<nom_server_name> et suivez les étapes indiquées.