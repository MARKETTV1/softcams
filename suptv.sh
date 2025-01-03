
echo " ✨✨✨✨SUPTV ✨✨✨✨"
echo " ✨✨✨✨OPENPLI9.X & 8.X ✨✨✨✨"

wait
wait
wait
wait

rm -r /usr/lib/enigma2/python/Plugins/Extensions/suptv

wait

wget -O /tmp/enigma2-plugin-extensions-suptv_4.1_all.ipk "https://github.com/MARKETTV1/softcams/raw/refs/heads/main/enigma2-plugin-extensions-suptv_4.1_all.ipk"

wait

opkg update && opkg install --force-overwrite /tmp/*.ipk

wait

if [ $? -eq 0 ]; then
   echo "🎉 Installation was successful! The package is ready for use. 🚀"
else
    echo "❌ An error occurred during installation! Please try again. 😔"
fi

rm -r /tmp/*.ipk

echo " ✨✨✨✨OPENPLI9.X & 8.X ✨✨✨✨"

exit 0

