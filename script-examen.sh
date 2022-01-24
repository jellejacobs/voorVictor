#! /bin/bash

# Stop het script bij een onbestaande variabele

### Algemene variabelen wrden eerst gedefinieerd
# De map waarin je op zoek gaat naar het opgegeven type bestanden
SEARCH_DIR=
# De map waar je de documenten gaat opslaan
BACKUP_TEMP_DIR="~/BackupDir"
BACKUP_DIR="/var/www/backups"


### --- functions ---

# installeer de webserver, ook al zou de service al geïnstalleerd zijn. 
# Gebruik idempotente commando's waar mogelijk.
function install_nginx {
  # Ga na of de map voor de web-inhoud bestaat. Indien niet, maak ze aan
  if [ ! -d  $BACKUP_DIR   ] ; then 
    sudo mkdir -p $BACKUP_DIR
  fi

  # Installeer de webserver software 
        sudo dnf install -y nginx > /dev/null 
  # Pas de configuratie van de webserver aan
  sudo sed -i "s+/usr/share/nginx/html+${BACKUP_DIR}+g" /etc/nginx/nginx.conf &> /dev/null  

  # Herstart de service
 
sudo systemctl enable nginx
 sudo systemctl stop nginx
 sudo systemctl start nginx
  # Firewall ... 
 sudo firewall-cmd --add-service=http --permanent
 sudo firewall-cmd --add-service=https --permanent
 sudo firewall-cmd --permanent --zone=public --add-port=80/tcp
 sudo firewall-cmd --permanent --zone=public --add-port=443/tcp
 sudo firewall-cmd --reload 
}

# kopieer de symbolisch gelinkte bestanden van de zoekmap naar de backupmap, inclusief indexbestand
function copy_symlink_files {
  local WorkDIR=$1
  local DestDIR=$2
# maak de tarbal aan

  # kopieer de tarball naar de doelmap

  # geef de inhoud van de tarbal weer

}


### --- main script ---
### Voer de opeenvolgende taken uit

# installeer nginx, ook al is het reeds geïnstalleerd. 
install_nginx

# geef de datum weer van vandaag, gebruik deze globale variabele
DATUM="${date}"
printf "Vandaag ..." ${date}

# leegmaken doelmap

copy_symlink_files ...

rename_mtaMTA ...

readonly_permissions ... 

create_tarball ...

# Einde script

