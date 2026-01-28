#!/bin/sh

opkg remove enigma2-softcams-oscam-all-images_11940-emu-802-arm+mips_all.ipk

# Téléchargement du fichier .ipk depuis GitHub
wget -O /tmp/enigma2-softcams-oscam-all-images_11940-emu-802-arm+mips_all.ipk https://github.com/MARKETTV1/softcams/raw/refs/heads/main/enigma2-softcams-oscam-all-images_11940-emu-802-arm+mips_all.ipk

# Installation du fichier .ipk
opkg install /tmp/enigma2-softcams-oscam-all-images_11940-emu-802-arm+mips_all.ipk

# Optionnel: Redémarrer Enigma2 ou recharger le service
sleep 3
killall -9 enigma2
exit 0
