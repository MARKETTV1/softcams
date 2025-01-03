#!/bin/sh

opkg remove enigma2-plugin-extensions-suptv

# Téléchargement du fichier .ipk depuis GitHub
wget -O /tmp/enigma2-plugin-extensions-suptv_4.1_all.ipk https://github.com/MARKETTV1/softcams/raw/refs/heads/main/enigma2-plugin-extensions-suptv_4.1_all.ipk

# Installation du fichier .ipk
opkg install /tmp/enigma2-plugin-extensions-suptv_4.1_all.ipk

# Optionnel: Redémarrer Enigma2 ou recharger le service
echo ""
echo ""
echo ""
echo "#########################################################"
echo ""
echo ""
echo "#########################################################"
echo "#       SUPTV [OPENPL] INSTALLED SUCCESSFULLY          #"
echo "#                 KARIM & SAID MABROUR SOBHI            #"              
echo "#                     support                           #"
echo "#                                                       #"
echo "#########################################################"
echo "#           your Device will RESTART Now                #"
echo "#########################################################"
sleep 3
killall -9 enigma2
exit 0
