#!/bin/sh

AIR_LOC=runtimes/AdobeAIRSDK/bin
FLEX_LOC=runtimes/flex_sdk_4.6/bin
KEY_LOC=keys/android
BUILD_LOC=builds/android

$FLEX_LOC/amxmlc -swf-version=20 -compiler.source-path=src -static-link-runtime-shared-libraries=true $AIR_PROJECT_ROOT/Main.as -output $BIN_DIR/Main.swf

$AIR_LOC/adt -package -target apk-captive-runtime -storetype pkcs12 -keystore $KEY_LOC/selfSigned.pfx -storepass Apangea%123 \
$BUILD_LOC/TTMMobile.apk $BIN_DIR/ttm_mobile-app-as3-as.xml $BIN_DIR/Main.swf $AIR_PROJECT_ROOT/icons
