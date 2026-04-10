#!/bin/sh

# ==============================================
# SCRIPT : DOWNLOAD AND INSTALL Oscam_EMU 11945
# ==============================================
# روابط التحميل من GitHub
# https://github.com/MARKETTV1/softcams
# ==============================================

########################################################################################################################
# Plugin - Oscam_EMU 11945-emu-802
########################################################################################################################

MY_IPK="enigma2-softcams-oscam-all-images_11945-emu-802-arm+mips_all.ipk"
MY_DEB="enigma2-softcams-oscam-all-images_11945-emu-802-arm+mips_all.deb"

########################################################################################################################
# روابط التحميل المباشرة
########################################################################################################################

IPK_URL="https://github.com/MARKETTV1/softcams/raw/refs/heads/main/enigma2-softcams-oscam-all-images_11945-emu-802-arm+mips_all.ipk"
DEB_URL="https://github.com/MARKETTV1/softcams/raw/refs/heads/main/enigma2-softcams-oscam-all-images_11945-emu-802-arm+mips_all.deb"

########################################################################################################################
# Auto ... لا تغير شيء
########################################################################################################################

# تحديد الحزمة المناسبة حسب النظام
if which dpkg > /dev/null 2>&1; then
	MY_FILE=$MY_DEB
	MY_URL=$DEB_URL
else
	MY_FILE=$MY_IPK
	MY_URL=$IPK_URL
fi

MY_TMP_FILE="/tmp/"$MY_FILE

echo ''
echo '************************************************************'
echo '**                         STARTED                        **'
echo '************************************************************'
echo "**            Oscam_EMU 11945-emu-802                     **"
echo "**            Source: MARKETTV1 / softcams                **"
echo "************************************************************"
echo ''

# حذف الملف السابق إن وجد
rm -f $MY_TMP_FILE > /dev/null 2>&1

# تحميل الحزمة
MY_SEP='============================================================='
echo $MY_SEP
echo "جاري تحميل: "$MY_FILE
echo $MY_SEP
echo ''
echo "الرابط: "$MY_URL
echo ''
wget --no-check-certificate -T 10 $MY_URL -P "/tmp/"

# التحقق من نجاح التحميل
if [ -f $MY_TMP_FILE ]; then
	# تثبيت الحزمة
	echo ''
	echo $MY_SEP
	echo 'بدء التثبيت...'
	echo $MY_SEP
	echo ''
	
	if which dpkg > /dev/null 2>&1; then
		echo "نظام Debian تم اكتشافه (dpkg)"
		dpkg -i --force-overwrite $MY_TMP_FILE
	else
		echo "نظام Opkg تم اكتشافه"
		opkg install --force-reinstall $MY_TMP_FILE
	fi
	
	MY_RESULT=$?
	
	# النتيجة
	echo ''
	echo ''
	if [ $MY_RESULT -eq 0 ]; then
		echo "   >>>>   تم التثبيت بنجاح   <<<<"
		echo ''
		echo "   >>>>   جاري إعادة التشغيل...   <<<<"
		
		# حذف الملف المؤقت
		rm -f $MY_TMP_FILE > /dev/null 2>&1
		
		# إعادة تشغيل الانغما2
		if which systemctl > /dev/null 2>&1; then
			sleep 2
			systemctl restart enigma2
		else
			init 4
			sleep 4
			init 3
		fi
	else
		echo "   >>>>   فشل التثبيت !   <<<<"
		echo "   >>>>   تأكد من اتصال الإنترنت   <<<<"
	fi
	
	echo ''
	echo '**************************************************'
	echo '**                   FINISHED                   **'
	echo '**************************************************'
	echo ''
	exit 0
else
	echo ''
	echo "فشل التحميل !"
	echo "تأكد من:"
	echo "1 - اتصال الإنترنت"
	echo "2 - الرابط صحيح"
	echo "3 - الجهاز متصل بالشبكة"
	exit 1
fi
