#!/bin/sh

AIR_LOC=runtimes/AdobeAIRSDK/bin
FLEX_LOC=runtimes/flex_sdk_4.6/bin
KEY_LOC=keys/android
BUILD_LOC=builds/android

$FLEX_LOC/amxmlc -swf-version=20 \
-compiler.source-path=src -static-link-runtime-shared-libraries=true \
$AIR_PROJECT_ROOT/Main.as -output $BUILD_DIR/flex/Main.swf

$FLEX_LOC/amxmlc -swf-version=20 \
-compiler.source-path=src -static-link-runtime-shared-libraries=true \
experiments/blank_air/Blank.as -output $BUILD_DIR/flex/Blank.swf

$AIR_LOC/adt -package -target apk-captive-runtime -storetype pkcs12 \
-keystore $KEY_LOC/selfSigned.pfx -storepass Apangea%123 \
$BUILD_LOC/TTMMobile.apk \
$BIN_DIR/ttm_mobile-app-as3-as.xml \
-C $BUILD_DIR/flex Main.swf Blank.swf \
-C $AIR_PROJECT_ROOT icons

$FLEX_LOC/../lib/android/bin/adb -d uninstall air.proto.ttm.mobileplayer

$FLEX_LOC/../lib/android/bin/adb -d install $BUILD_LOC/TTMMobile.apk