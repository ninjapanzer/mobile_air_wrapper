#!/bin/sh

AIR_LOC=runtimes/AdobeAIRSDK/bin
FLEX_LOC=runtimes/flex_sdk_4.6/bin
KEY_LOC=keys/ios
BUILD_LOC=builds/ios

$FLEX_LOC/amxmlc Main.as

$AIR_LOC/adt -package -target ipa-debug \
-keystore $KEY_LOC/ttm_app_key.p12 -storetype pkcs12 -storepass Apangea%123 \
-provisioning-profile $KEY_LOC/TTM_AIR_ADHOC_Mobile.mobileprovision \
$BUILD_LOC/TTM_Mobile.ipa \
ttm_mobile-app-as3-as.xml \
Main.swf icons