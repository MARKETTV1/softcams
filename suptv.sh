echo "#####################################"
echo " ✨✨✨✨SUPTV ✨✨✨✨"
echo " ✨✨✨✨OPENPLI9.X & 8.X ✨✨✨✨"
echo "#####################################"
wait
wait
wait
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
init 4
init 3
echo " ✨✨✨✨SUPTV ✨✨✨✨"



