#!/bin/bash

echo "⚠ ATTENZIONE: Questo script rimuoverà completamente Moodle e il database MySQL/MariaDB!"
read -p "Vuoi procedere? (s/n): " choice

if [[ $choice != "s" ]]; then
    echo "Operazione annullata."
    exit 1
fi

echo "Arresto dei servizi Apache e MySQL..."
sudo systemctl stop apache2
sudo systemctl stop mysql

echo "Rimozione dei file di Moodle..."
sudo rm -rf /var/www/html/moodle
sudo rm -rf /var/www/moodledata

echo "Rimozione del database di Moodle..."
sudo mysql -u root -p -e "DROP DATABASE moodle;"
sudo mysql -u root -p -e "DROP USER 'moodleuser'@'localhost';"
sudo mysql -u root -p -e "FLUSH PRIVILEGES;"

echo "Rimozione del file di configurazione di Apache..."
sudo rm -f /etc/apache2/sites-available/moodle.conf
sudo a2dissite moodle.conf

echo "Pulizia della cache di Apache..."
sudo systemctl restart apache2

echo "Disinstallazione dei pacchetti installati..."
sudo apt remove --purge -y apache2 mysql-server php libapache2-mod-php php-mysql php-xml php-intl php-zip php-gd php-curl php-mbstring git
sudo apt autoremove -y
sudo apt clean

echo "Eliminazione dei log di Moodle e MySQL..."
sudo rm -rf /var/log/apache2/*
sudo rm -rf /var/log/mysql/*

echo "Moodle è stato completamente rimosso!"
