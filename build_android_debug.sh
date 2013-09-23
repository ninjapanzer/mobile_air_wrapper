#!/bin/sh

AIR_LOC=runtimes/AdobeAIRSDK/bin
FLEX_LOC=runtimes/flex_sdk_4.6/bin
KEY_LOC=keys/android
BUILD_LOC=builds/android

$AIR_LOC/adt -package -target apk -storetype pkcs12 -keystore $KEY_LOC/selfSigned.pfx -storepass Apangea%123 \
$BUILD_LOC/TTMMobile.apk ttm_mobile-app-as3-as.xml Main.swf icons