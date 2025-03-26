#!/bin/bash

# Farben für die Ausgabe
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # Keine Farbe

echo -e "${GREEN}Starte Server-Update und Bereinigung...${NC}"

# System-Update
echo -e "${GREEN}1. Aktualisiere Paketlisten...${NC}"
sudo apt update || { echo -e "${RED}Fehler beim Aktualisieren der Paketlisten.${NC}" ; exit 1; }

# System-Update-Liste
echo -e "${GREEN}2. Zeige verfügbare Updates...${NC}"
sudo apt list --upgradable  || { echo -e "${RED}Fehler beim Aktualisieren der Paketlisten.${NC}" ; exit 1; }

echo -e "${GREEN}3. Installiere verfügbare Updates...${NC}"
sudo apt upgrade -y || { echo -e "${RED}Fehler beim Aktualisieren der Pakete.${NC}" ; exit 1; }

# Automatische Entfernung von nicht mehr benötigten Paketen
echo -e "${GREEN}4. Entferne unnötige Pakete...${NC}"
sudo apt autoremove -y || { echo -e "${RED}Fehler beim Entfernen von Paketen.${NC}" ; exit 1; }

# Cache bereinigen
echo -e "${GREEN}5. Bereinige den Paket-Cache...${NC}"
sudo apt autoclean || { echo -e "${RED}Fehler beim Bereinigen des Caches.${NC}" ; exit 1; }

# Neustart-Check
if [ -f /var/run/reboot-required ]; then
    echo -e "${RED}Ein Neustart ist erforderlich. Starte das System neu.${NC}"
else
    echo -e "${GREEN}Kein Neustart erforderlich. Der Server ist auf dem neuesten Stand.${NC}"
fi

echo -e "${GREEN}Server-Update und Bereinigung abgeschlossen!${NC}"

echo -e "${GREEN}Vielen Dank für die Nutzung meines Update- und Bereinigungsscript für Debian Server!${NC}"

