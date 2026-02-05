#!/bin/sh

# سكريبت لتثبيت OSCam المناسب لنظام التشغيل
# Created for Enigma2 receivers

# إزالة أي نسخة سابقة (إذا كانت موجودة)
echo "Removing previous OSCam version if exists..."
opkg remove enigma2-softcams-oscam-all-images 2>/dev/null
dpkg --purge enigma2-softcams-oscam-all-images 2>/dev/null

# الكشف عن نظام التشغيل
echo "Detecting system type..."

# طريقة 1: فحص وجود dpkg (لـ DreamOS)
if command -v dpkg >/dev/null 2>&1; then
    SYSTEM="DREAMOS"
    echo "System detected: DreamOS (OE 2.5/2.6)"
    
    # تثبيت ملف .deb
    echo "Downloading .deb file..."
    wget -O /tmp/oscam_install.deb "https://github.com/MARKETTV1/softcams/releases/download/enigma2-softcams-oscam-all-images_11942-emu-802-arm%2Bmips_all/enigma2-softcams-oscam-all-images_11942-emu-802-arm+mips_all.deb"
    
    if [ -f "/tmp/oscam_install.deb" ]; then
        echo "Installing .deb package..."
        dpkg -i --force-overwrite /tmp/oscam_install.deb
        
        if [ $? -eq 0 ]; then
            echo "Installation successful!"
        else
            echo "Installation failed, trying with force-depends..."
            dpkg -i --force-depends /tmp/oscam_install.deb
        fi
        
        # تنظيف الملف المؤقت
        rm -f /tmp/oscam_install.deb
    else
        echo "Error: Failed to download .deb file"
        exit 1
    fi

# طريقة 2: فحص وجود opkg (لـ OE 2.0)
elif command -v opkg >/dev/null 2>&1; then
    SYSTEM="OE20"
    echo "System detected: OE 2.0"
    
    # تثبيت ملف .ipk
    echo "Downloading .ipk file..."
    wget -O /tmp/oscam_install.ipk "https://github.com/MARKETTV1/softcams/releases/download/enigma2-softcams-oscam-all-images_11942-emu-802-arm%2Bmips_all/enigma2-softcams-oscam-all-images_11942-emu-802-arm+mips_all.ipk"
    
    if [ -f "/tmp/oscam_install.ipk" ]; then
        echo "Installing .ipk package..."
        opkg install --force-overwrite /tmp/oscam_install.ipk
        
        if [ $? -eq 0 ]; then
            echo "Installation successful!"
        else
            echo "Installation failed, trying with force-depends..."
            opkg install --force-depends /tmp/oscam_install.ipk
        fi
        
        # تنظيف الملف المؤقت
        rm -f /tmp/oscam_install.ipk
    else
        echo "Error: Failed to download .ipk file"
        exit 1
    fi

else
    echo "Error: Cannot determine system type (opkg or dpkg not found)"
    exit 1
fi

# إعادة التشغيل بعد التثبيت
echo "Installation completed. Restarting Enigma2..."
echo "Waiting 3 seconds..."
sleep 3

# طريقة آمنة لإعادة تشغيل واجهة Enigma2
if [ -f "/etc/init.d/enigma2" ]; then
    /etc/init.d/enigma2 restart
elif [ -f "/etc/init.d/enigma2.sh" ]; then
    /etc/init.d/enigma2.sh restart
else
    # الطريقة البديلة
    killall -9 enigma2
fi

echo "Script finished successfully!"
exit 0
