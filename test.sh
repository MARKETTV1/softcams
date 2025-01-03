#!/bin/sh

# التحقق إذا كان البلوجين مثبتًا بالفعل
if opkg list-installed | grep -q "enigma2-plugin-extensions-suptv"; then
    echo "البلوجين موجود مسبقًا، سيتم حذفه الآن."
    opkg remove enigma2-plugin-extensions-suptv
else
    echo "البلوجين غير مثبت."
fi

# تحميل ملف .ipk من GitHub
wget -O /tmp/enigma2-plugin-extensions-suptv_4.1_all.ipk https://github.com/MARKETTV1/softcams/raw/refs/heads/main/enigma2-plugin-extensions-suptv_4.1_all.ipk

# تثبيت البلوجين من الملف الذي تم تحميله
opkg install /tmp/enigma2-plugin-extensions-suptv_4.1_all.ipk

# رسالة تأكيد التثبيت
echo ""
echo "#########################################################"
echo "#           SUPTV [OPENPL] INSTALLED SUCCESSFULLY       #"
echo "#           KARIM & SAID MABROUR SOBHI                  #"
echo "#                   support                           #"
echo "#########################################################"

# إعادة تشغيل خدمة Enigma2
echo "جهازك سيعيد التشغيل الآن"
sleep 3
killall -9 enigma2

# إنهاء السكربت
exit 0
