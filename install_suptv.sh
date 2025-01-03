#!/bin/sh

# Téléchargement du fichier .ipk depuis GitHub
wget -O /tmp/enigma2-plugin-extensions-suptv_4.1_all.ipk https://github.com/MARKETTV1/softcams/raw/refs/heads/main/enigma2-plugin-extensions-suptv_4.1_all.ipk

# Installation du fichier .ipk
opkg install /tmp/enigma2-plugin-extensions-suptv_4.1_all.ipk

# Nettoyage (supprimer le fichier après installation)
rm /tmp/*.ipk

# Optionnel: Redémarrer Enigma2 ou recharger le service
reboot
