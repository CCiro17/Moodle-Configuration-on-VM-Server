#!/bin/bash

# Definizione del percorso del file php.ini
PHP_INI="/etc/php/8.3/apache2/php.ini"

# Controlliamo se il file php.ini esiste
if [ ! -f "$PHP_INI" ]; then
    echo "Errore: Il file $PHP_INI non esiste!"
    exit 1
fi

echo "Rimuoviamo il punto e virgola (;) davanti a max_input_vars se presente..."

# Rimuove il ";" solo se la riga esiste ed è commentata
sudo sed -i 's/^\s*;\s*max_input_vars\s*=/max_input_vars =/' "$PHP_INI"

echo "Commento rimosso, ora modifichiamo il valore..."

# Modifica il valore di max_input_vars a 5000 se presente un valore diverso
sudo sed -i 's/^max_input_vars\s*=\s*[0-9]\+/max_input_vars = 5000/' "$PHP_INI"

# Controllo se la modifica è avvenuta
if grep -q "^max_input_vars = 5000" "$PHP_INI"; then
    echo "max_input_vars impostato correttamente a 5000!"
else
    echo "Errore: impossibile modificare max_input_vars!"
    exit 1
fi

# Ricarichiamo i daemon di sistema
echo "Ricaricamento dei daemon di sistema..."
sudo systemctl daemon-reload

# Riavviamo Apache per applicare le modifiche
echo "Riavvio di Apache..."
sudo systemctl restart apache2

# Messaggio di completamento
echo "Configurazione completata con successo!"

