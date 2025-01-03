rm -r /usr/lib/enigma2/python/Plugins/Extensions/suptv

wait

wget -O /tmp/enigma2-plugin-extensions-suptv_4.1_all.ipk "https://github.com/MARKETTV1/softcams/raw/refs/heads/main/enigma2-plugin-extensions-suptv_4.1_all.ipk"

wait

opkg update && opkg install --force-overwrite /tmp/*.ipk

wait

rm -r /tmp/*.ipk



exit 0

