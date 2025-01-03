 #!/bin/bash

# تحميل الحزمة باستخدام wget
echo "تحميل الحزمة من الرابط..."
wget -O /tmp/enigma2-plugin-extensions-suptv_4.1_all.ipk "https://github.com/MARKETTV1/softcams/blob/main/enigma2-plugin-extensions-suptv_4.1_all.ipk?raw=true"

# تثبيت الحزمة باستخدام opkg
echo "تثبيت الحزمة..."
opkg install /tmp/enigma2-plugin-extensions-suptv_4.1_all.ipk

# تنظيف الملفات المؤقتة
echo "تنظيف الملفات المؤقتة..."
rm -f /tmp/enigma2-plugin-extensions-suptv_4.1_all.ipk

echo "تم التثبيت بنجاح!"

  
