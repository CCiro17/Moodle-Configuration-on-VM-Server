# Installazione di Moodle su Server Locale

Questo progetto fornisce tre script shell per automatizzare l'installazione, la configurazione e la rimozione di Moodle su un server locale basato su Linux (Ubuntu/Debian). Gli script sono pensati per semplificare il processo e minimizzare gli errori manuali.

## Requisiti

- Sistema operativo: Ubuntu/Debian (o compatibili)
- Permessi di amministratore (sudo)
- Connessione a Internet

## Struttura del progetto

Il progetto include i seguenti script:

1. **`script_install_moodle.sh`** → Installazione di Moodle e dei pacchetti necessari.
2. **`secondo_script.sh`** → Configurazione avanzata di PHP per garantire il corretto funzionamento di Moodle.
3. **`pulizia.sh`** → Rimozione completa di Moodle e delle sue dipendenze.

---

## 1️⃣ Installazione di Moodle

Per installare Moodle sul server locale, eseguire il seguente comando:

```bash
bash script_install_moodle.sh
```

Questo script eseguirà automaticamente:
- L'aggiornamento del sistema operativo.
- L'installazione di Apache, MySQL, PHP e delle estensioni richieste.
- La creazione del database e dell'utente MySQL per Moodle.
- Il download e la configurazione di Moodle.
- L'impostazione del server Apache per servire Moodle.

Al termine dell'installazione, Moodle sarà accessibile all'indirizzo:
```
http://localhost/moodle
```

---

## 2️⃣ Configurazione aggiuntiva

Dopo l'installazione, è necessario configurare alcuni parametri di PHP per evitare problemi durante l'uso di Moodle. Questo passaggio può essere effettuato con il comando:

```bash
bash secondo_script.sh
```

Questo script:
- Modifica il file `php.ini` per aumentare il valore di `max_input_vars` a 5000.
- Ricarica i servizi di sistema per applicare le modifiche.
- Riavvia Apache per garantire che Moodle funzioni correttamente.

---

## 3️⃣ Risoluzione dei problemi e rimozione

Se durante l'installazione o la configurazione si verificano problemi, è possibile rimuovere completamente Moodle ed eseguire nuovamente l'installazione utilizzando lo script di pulizia.

Per eseguire la rimozione completa, digitare:

```bash
bash pulizia.sh
```

⚠ **Attenzione**: Questo script eliminerà definitivamente Moodle, il database e tutti i file associati. Verranno inoltre disinstallati i pacchetti di Apache, MySQL e PHP.

Lo script esegue:
- L'arresto dei servizi Apache e MySQL.
- La rimozione dei file di Moodle e della directory dei dati.
- L'eliminazione del database e dell'utente MySQL.
- La rimozione della configurazione di Apache.
- La disinstallazione dei pacchetti installati.
- La pulizia dei log e della cache.

Una volta completata la rimozione, è possibile eseguire nuovamente `script_install_moodle.sh` per reinstallare Moodle da zero.

---

## Conclusione

Questi script permettono di installare, configurare e rimuovere Moodle in modo semplice e automatizzato. Se si verificano errori, controllare i log di Apache e MySQL per ulteriori dettagli:

```bash
tail -f /var/log/apache2/error.log
```

```bash
tail -f /var/log/mysql/error.log
```

Buona installazione e gestione di Moodle! 🚀
