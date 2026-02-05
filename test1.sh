#!/bin/sh
# Auto-detecting OSCam installer - FIXED VERSION

echo "=== OSCam Auto Installer ==="

# الطريقة الصحيحة للكشف عن النظام
if [ -f "/etc/image-version" ] && grep -q "openatv\|dream\|opendroid" /etc/image-version 2>/dev/null; then
    SYSTEM="DREAMOS"
    echo "System: DreamOS/OE 2.5/2.6 (openATV detected)"
elif command -v dpkg >/dev/null 2>&1; then
    SYSTEM="DREAMOS"
    echo "System: DreamOS (dpkg detected)"
else
    SYSTEM="OE20"
    echo "System: OE 2.0"
fi

cd /tmp

if [ "$SYSTEM" = "DREAMOS" ]; then
    echo "Downloading .deb package for DreamOS..."
    wget "https://github.com/MARKETTV1/softcams/releases/download/enigma2-softcams-oscam-all-images_11942-emu-802-arm%2Bmips_all/enigma2-softcams-oscam-all-images_11942-emu-802-arm+mips_all.deb"
    
    if [ -f "enigma2-softcams-oscam-all-images_11942-emu-802-arm+mips_all.deb" ]; then
        echo "Installing .deb package..."
        dpkg -i --force-overwrite enigma2-softcams-oscam-all-images_11942-emu-802-arm+mips_all.deb
    fi
else
    echo "Downloading .ipk package for OE 2.0..."
    wget "https://github.com/MARKETTV1/softcams/releases/download/enigma2-softcams-oscam-all-images_11942-emu-802-arm%2Bmips_all/enigma2-softcams-oscam-all-images_11942-emu-802-arm+mips_all.ipk"
    
    if [ -f "enigma2-softcams-oscam-all-images_11942-emu-802-arm+mips_all.ipk" ]; then
        echo "Installing .ipk package..."
        opkg install --force-overwrite enigma2-softcams-oscam-all-images_11942-emu-802-arm+mips_all.ipk
    fi
fi

# تشغيل OSCam بدلاً من ncam
echo "Stopping ncam and starting OSCam..."
if [ -f "/etc/init.d/softcam" ]; then
    /etc/init.d/softcam stop 2>/dev/null
    sleep 2
    # تغيير الافتراضي إلى OSCam
    if [ -f "/usr/bin/oscam" ]; then
        update-alternatives --set softcam /usr/bin/oscam 2>/dev/null || true
    fi
    /etc/init.d/softcam start
fi

# إعادة التشغيل
echo "Restarting Enigma2..."
init 4
sleep 3
init 3

# تنظيف
rm -f /tmp/*.deb /tmp/*.ipk 2>/dev/null
rm -f "$0"

echo "=== Installation completed ==="
