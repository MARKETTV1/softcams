
#!/bin/sh

opkg remove enigma2-plugin-softcams-powercam-oscam_11939-emu-r802_all.ipk

# Téléchargement du fichier .ipk depuis GitHub
wget -O /tmp/enigma2-plugin-softcams-powercam-oscam_11939-emu-r802_all.ipk https://github.com/MARKETTV1/softcams/raw/refs/heads/main/enigma2-plugin-softcams-powercam-oscam_11939-emu-r802_all.ipk

# Installation du fichier .ipk
opkg install /tmp/enigma2-plugin-softcams-ncam_V15.6-r0_all.ipk

# Optionnel: Redémarrer Enigma2 ou recharger le service
sleep 3
killall -9 enigma2
exit 0


powercam-oscam_11939
