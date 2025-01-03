#!/bin/sh

# مسار تخزين الملف المؤقت
TEMP_DIR="/tmp"

# رابط تحميل الحزمة
IPK_URL="https://github.com/MARKETTV1/softcams/raw/refs/heads/main/enigma2-plugin-extensions-suptv_4.1_all.ipk"

# اسم الحزمة
IPK_FILE="$TEMP_DIR/enigma2-plugin-extensions-suptv_4.1_all.ipk"

# التأكد من وجود المجلد /tmp
if [ ! -d "$TEMP_DIR" ]; then
    echo "Temporary directory $TEMP_DIR not found. Exiting."
    exit 1
fi

# تنزيل الحزمة باستخدام wget مع بعض الخيارات
echo "Downloading the IPK package..."
wget --quiet --show-progress --tries=3 -O "$IPK_FILE" "$IPK_URL"

# التحقق من نجاح التحميل
if [ ! -f "$IPK_FILE" ]; then
    echo "Download failed! File not found at $IPK_FILE."
    exit 1
fi

# تثبيت الحزمة باستخدام opkg
echo "Installing the IPK package..."
opkg install "$IPK_FILE"

# التحقق من التثبيت
if [ $? -eq 0 ]; then
    echo "Package installed successfully!"
else
    echo "Package installation failed!"
fi

# إزالة الحزمة المؤقتة بعد التثبيت
rm -f "$IPK_FILE"
echo "Temporary files cleaned up."

exit 0
