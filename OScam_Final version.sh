#!/bin/sh

# سكريبت بسيط لتثبيت Oscam_EMU

echo "بدء تثبيت Oscam_EMU 11945..."

# تحديد النظام وتحميل الحزمة المناسبة
if which dpkg > /dev/null 2>&1; then
    echo "تحميل حزمة .deb..."
    wget https://github.com/MARKETTV1/softcams/raw/refs/heads/main/enigma2-softcams-oscam-all-images_11945-emu-802-arm+mips_all.deb -O /tmp/oscam.deb
    dpkg -i --force-overwrite /tmp/oscam.deb
else
    echo "تحميل حزمة .ipk..."
    wget https://github.com/MARKETTV1/softcams/raw/refs/heads/main/enigma2-softcams-oscam-all-images_11945-emu-802-arm+mips_all.ipk -O /tmp/oscam.ipk
    opkg install --force-reinstall /tmp/oscam.ipk
fi

# تنظيف
rm -f /tmp/oscam.*

# إعادة التشغيل
echo "إعادة تشغيل الجهاز..."
init 4 && sleep 4 && init 3

echo "تم الانتهاء!"
