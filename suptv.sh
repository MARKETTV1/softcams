 #!/bin/bash

echo "The package has been installed"
wget -O /tmp/enigma2-plugin-extensions-suptv_4.1_all.ipk "https://github.com/MARKETTV1/softcams/blob/main/enigma2-plugin-extensions-suptv_4.1_all.ipk?raw=true"

# Installation is in progress opkg
echo "Installation is in progress"
opkg install /tmp/enigma2-plugin-extensions-suptv_4.1_all.ipk


echo "The installation was successful"


  
