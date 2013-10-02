#!/bin/sh

AIR_LOC=runtimes/AdobeAIRSDK/bin
FLEX_LOC=runtimes/flex_sdk_4.6/bin
KEY_LOC=keys/android
BUILD_LOC=builds/android

$FLEX_LOC/amxmlc Main.as
$FLEX_LOC/amxmlc -debug=true experiments/blank_air/blank.as

cp experiments/blank_air/Blank.swf ./Blank.swf

$AIR_LOC/adt -package -target apk-captive-runtime -storetype pkcs12 -keystore $KEY_LOC/selfSigned.pfx -storepass Apangea%123 \
$BUILD_LOC/TTMMobile.apk ttm_mobile-app-as3-as.xml Main.swf icons blank.swf

$FLEX_LOC/../lib/android/bin/adb -d uninstall air.proto.ttm.mobileplayer

$FLEX_LOC/../lib/android/bin/adb -d install $BUILD_LOC/TTMMobile.apk

#$FLEX_LOC/../lib/android/bin/adb logcat

rm blank.swf