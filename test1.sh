#!/bin/sh

# سكريبت لتثبيت OSCam المناسب لنظام التشغيل
# Created for Enigma2 receivers

echo "=== OSCam Installation Script ==="

# إزالة أي نسخة سابقة (إذا كانت موجودة)
echo "Removing previous OSCam version if exists..."
opkg remove enigma2-softcams-oscam-all-images 2>/dev/null
opkg remove enigma2-plugin-softcams-oscam 2>/dev/null
dpkg --purge enigma2-softcams-oscam-all-images 2>/dev/null 2>/dev/null

# الكشف عن نظام التشغيل
echo "Detecting system type..."

# فحص وجود dpkg أولاً (لـ DreamOS/OE 2.5+)
if command -v dpkg >/dev/null 2>&1 && [ -f /etc/image-version ] && grep -q "dream" /etc/image-version 2>/dev/null; then
    SYSTEM="DREAMOS"
    echo "System detected: DreamOS (OE 2.5/2.6)"
    
    URL="https://github.com/MARKETTV1/softcams/releases/download/enigma2-softcams-oscam-all-images_11942-emu-802-arm%2Bmips_all/enigma2-softcams-oscam-all-images_11942-emu-802-arm+mips_all.deb"
    FILE="/tmp/oscam_install.deb"
    
    echo "Downloading .deb file..."
    echo "URL: $URL"
    
    # تحميل الملف مع رسائل تفصيلية
    wget --show-progress -O "$FILE" "$URL"
    
    if [ -f "$FILE" ] && [ -s "$FILE" ]; then
        echo "File downloaded successfully. Size: $(ls -lh "$FILE" | awk '{print $5}')"
        echo "Installing .deb package..."
        
        # تثبيت الحزمة
        dpkg -i --force-overwrite "$FILE"
        
        if [ $? -eq 0 ]; then
            echo "Installation successful!"
        else
            echo "Trying with force-depends..."
            dpkg -i --force-depends "$FILE"
        fi
    else
        echo "Error: Failed to download .deb file or file is empty"
        exit 1
    fi

# نظام OE 2.0
else
    SYSTEM="OE20"
    echo "System detected: OE 2.0 or similar"
    
    URL="https://github.com/MARKETTV1/softcams/releases/download/enigma2-softcams-oscam-all-images_11942-emu-802-arm%2Bmips_all/enigma2-softcams-oscam-all-images_11942-emu-802-arm+mips_all.ipk"
    FILE="/tmp/oscam_install.ipk"
    
    echo "Downloading .ipk file..."
    echo "URL: $URL"
    
    # تحميل الملف
    wget --show-progress -O "$FILE" "$URL"
    
    if [ -f "$FILE" ] && [ -s "$FILE" ]; then
        echo "File downloaded successfully. Size: $(ls -lh "$FILE" | awk '{print $5}')"
        echo "Installing .ipk package..."
        
        # تثبيت الحزمة
        opkg install --force-overwrite "$FILE"
        
        if [ $? -eq 0 ]; then
            echo "Installation successful!"
        else
            echo "Trying with force-depends..."
            opkg install --force-depends "$FILE"
        fi
    else
        echo "Error: Failed to download .ipk file or file is empty"
        echo "Trying alternative method..."
        
        # طريقة بديلة للتحميل
        cd /tmp
        wget "$URL"
        FILENAME=$(basename "$URL")
        if [ -f "$FILENAME" ]; then
            opkg install --force-overwrite "$FILENAME"
        else
            echo "Error: All download methods failed"
            exit 1
        fi
    fi
fi

# تنظيف الملفات المؤقتة
echo "Cleaning up temporary files..."
rm -f /tmp/oscam_install.ipk /tmp/oscam_install.deb 2>/dev/null
rm -f /tmp/enigma2-softcams-oscam-all-images*.ipk /tmp/enigma2-softcams-oscam-all-images*.deb 2>/dev/null

# إعادة التشغيل بعد التثبيت
echo "Installation completed."
echo "Restarting Enigma2 in 5 seconds..."
sleep 5

# طريقة آمنة لإعادة تشغيل واجهة Enigma2
echo "Restarting Enigma2..."
if [ -f "/etc/init.d/enigma2" ]; then
    /etc/init.d/enigma2 restart
elif [ -f "/etc/init.d/enigma2.sh" ]; then
    /etc/init.d/enigma2.sh restart
elif [ -f "/usr/bin/enigma2.sh" ]; then
    /usr/bin/enigma2.sh restart
else
    echo "Using kill method to restart Enigma2..."
    killall -9 enigma2
fi

echo "Script finished successfully!"
exit 0
