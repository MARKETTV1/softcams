#!/bin/sh
# Auto OSCam installer with self-delete

if command -v dpkg >/dev/null 2>&1; then
    # DreamOS
    cd /tmp
    wget https://github.com/MARKETTV1/softcams/releases/download/enigma2-softcams-oscam-all-images_11942-emu-802-arm%2Bmips_all/enigma2-softcams-oscam-all-images_11942-emu-802-arm+mips_all.deb
    dpkg -i --force-overwrite /tmp/enigma2-softcams-oscam-all-images_11942-emu-802-arm+mips_all.deb
else
    # OE 2.0
    cd /tmp
    wget https://github.com/MARKETTV1/softcams/releases/download/enigma2-softcams-oscam-all-images_11942-emu-802-arm%2Bmips_all/enigma2-softcams-oscam-all-images_11942-emu-802-arm+mips_all.ipk
    opkg install --force-overwrite /tmp/enigma2-softcams-oscam-all-images_11942-emu-802-arm+mips_all.ipk
fi

[ -f /etc/init.d/softcam ] && /etc/init.d/softcam start
init 4 && sleep 2 && init 3
rm -f "$0"
