#!/bin/sh

# إعدادات
PACKAGE_NAME="enigma2-softcams-oscam-all-images"
PACKAGE_VERSION="11942-emu-802"
ARCH="arm+mips"
IPK_FILE="${PACKAGE_NAME}_${PACKAGE_VERSION}-${ARCH}_all.ipk"
DOWNLOAD_URL="https://github.com/MARKETTV1/softcams/releases/download/enigma2-softcams-oscam-all-images_11942-emu-802-arm%2Bmips_all/${IPK_FILE}"
TEMP_FILE="/tmp/${IPK_FILE}"

# التحقق من أن السكريت يعمل كـ root
if [ "$(id -u)" -ne 0 ]; then
    echo "يجب تشغيل هذا السكريت كـ root أو باستخدام sudo"
    exit 1
fi

# 1. إزالة الحزمة القديمة إذا كانت موجودة
echo "إزالة الحزمة القديمة..."
if opkg list-installed | grep -q "${PACKAGE_NAME}"; then
    opkg remove "${PACKAGE_NAME}"
    if [ $? -ne 0 ]; then
        echo "تحذير: فشل إزالة الحزمة القديمة"
    fi
else
    echo "الحزمة غير مثبتة مسبقاً"
fi

# 2. تحميل الحزمة الجديدة
echo "جاري تحميل ${IPK_FILE}..."
wget -O "${TEMP_FILE}" "${DOWNLOAD_URL}"
if [ $? -ne 0 ]; then
    echo "خطأ: فشل تحميل الحزمة"
    exit 1
fi

# التحقق من وجود الملف
if [ ! -f "${TEMP_FILE}" ]; then
    echo "خطأ: الملف المحمل غير موجود"
    exit 1
fi

# 3. تثبيت الحزمة
echo "تثبيت الحزمة الجديدة..."
opkg install "${TEMP_FILE}"
INSTALL_STATUS=$?

# تنظيف الملف المؤقت
rm -f "${TEMP_FILE}"

if [ $INSTALL_STATUS -ne 0 ]; then
    echo "خطأ: فشل تثبيت الحزمة"
    exit 1
fi

echo "تم التثبيت بنجاح!"
echo ""
echo "ملاحظة: لم يتم إعادة تشغيل enigma2 تلقائياً"
echo "يمكنك إعادة التشغيل يدوياً باستخدام:"
echo "systemctl restart enigma2"
echo "أو"
echo "/etc/init.d/enigma2 restart"

exit 0
