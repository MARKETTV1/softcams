#!/bin/bash

# تحميل الحزمة باستخدام wget
echo "Downloading the package..."
wget -O /tmp/enigma2-plugin-extensions-suptv_4.1_all.ipk "https://github.com/MARKETTV1/softcams/raw/refs/heads/main/enigma2-plugin-extensions-suptv_4.1_all.ipk"

# بدء التثبيت
echo "Installation is in progress..."
opkg install /tmp/enigma2-plugin-extensions-suptv_4.1_all.ipk

# التحقق من التثبيت
if [ $? -eq 0 ]; then
    echo "The installation was successful. "
    
else
    echo "There was an error during the installation. "
fi

# تنظيف الملفات المؤقتة
rm -f /tmp/enigma2-plugin-extensions-suptv_4.1_all.ipk

  
