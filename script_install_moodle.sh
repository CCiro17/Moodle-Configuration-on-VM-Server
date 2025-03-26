#!/bin/bash

# Aggiornamento del sistema
echo "Aggiornamento del sistema..."
sudo apt update && sudo apt upgrade -y  # Aggiorna la lista dei pacchetti e installa gli aggiornamenti disponibili

# Installazione dei pacchetti richiesti
echo "Installazione di Apache, MySQL e PHP..."
sudo apt install -y apache2 mysql-server php libapache2-mod-php php-mysql php-xml php-intl php-zip php-gd php-curl php-mbstring git  # Installa il server web Apache, MySQL, PHP e le estensioni necessarie

# Configurazione del database MySQL
echo "Configurazione del database MySQL..."
sudo mysql -u root -e "CREATE DATABASE moodle DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"  # Crea il database 'moodle' con il set di caratteri UTF-8
sudo mysql -u root -e "CREATE USER 'moodleuser'@'localhost' IDENTIFIED BY 'admin';"  # Crea un utente MySQL per Moodle con password
sudo mysql -u root -e "GRANT ALL PRIVILEGES ON moodle.* TO 'moodleuser'@'localhost';"  # Concede all'utente tutti i privilegi sul database 'moodle'
sudo mysql -u root -e "FLUSH PRIVILEGES;"  # Applica le modifiche ai permessi

# Scaricare e configurare Moodle
echo "Scaricamento e configurazione di Moodle..."
cd /var/www/html  # Si sposta nella directory principale di Apache
sudo wget https://download.moodle.org/download.php/direct/stable405/moodle-latest-405.tgz  # Scarica l'ultima versione di Moodle 4.0.5
sudo tar -xvzf moodle-latest-405.tgz  # Estrae il file tar.gz scaricato
sudo mv moodle /var/www/html/moodle  # Sposta la cartella estratta nella directory corretta
sudo mkdir /var/www/moodledata  # Crea la directory per i dati di Moodle
sudo chown -R www-data:www-data /var/www/html/moodle /var/www/moodledata  # Assegna i permessi di proprietà ad Apache
sudo chmod -R 755 /var/www/html/moodle  # Imposta i permessi per la cartella di Moodle

# Configurazione di Apache
echo "Configurazione di Apache..."
echo '<VirtualHost *:80>
    ServerAdmin admin@localhost
    DocumentRoot /var/www/html/moodle
    <Directory /var/www/html/moodle>
        AllowOverride All
    </Directory>
</VirtualHost>' | sudo tee /etc/apache2/sites-available/moodle.conf  # Crea il file di configurazione di Apache per Moodle

sudo a2ensite moodle.conf  # Abilita il sito Moodle su Apache
sudo systemctl restart apache2  # Riavvia Apache per applicare le modifiche

# Firewall
echo "Configurazione del firewall..."
sudo ufw allow 80/tcp  # Permette il traffico HTTP sulla porta 80

# Output finale
echo "Installazione completata! Accedi a Moodle su http://localhost/moodle"  # Messaggio di completamento
