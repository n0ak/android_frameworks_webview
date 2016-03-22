#!/bin/bash

# Update prebuilt WebView library with com.google.android.webview apk
# Usage : ./extract.sh
#
# http://www.apkmirror.com/apk/google-inc/android-system-webview/

if ! apktool d -f -s "com.google.android.webview.apk" 1>/dev/null; then
	echo "Failed to extract com.google.android.webview.apk with apktool!"
	exit 1
fi

NEWWEBVIEWVERSION=$(cat com.google.android.webview/apktool.yml | grep versionName | awk '{print $2}')
echo "Updating current WebView $NEWWEBVIEWVERSION ..."
echo $NEWWEBVIEWVERSION > VERSION
rm -rf x86
mv com.google.android.webview/lib/* .
rm -f webview.apk
rm -rf com.google.android.webview
7z x -otmp com.google.android.webview.apk 1>/dev/null
cd tmp
rm -rf lib
7z a -tzip -mx0 ../tmp.zip . 1>/dev/null
cd ..
rm -rf tmp
zipalign -v 4 tmp.zip webview.apk 1>/dev/null
rm tmp.zip
rm -rf com.google.android.webview
rm -rf com.google.android.webview.apk
