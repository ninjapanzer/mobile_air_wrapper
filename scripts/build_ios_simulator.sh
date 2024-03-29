#!/bin/sh

AIR_LOC=runtimes/AdobeAIRSDK/bin
FLEX_LOC=runtimes/flex_sdk_4.6/bin
KEY_LOC=keys/ios
BUILD_LOC=builds/ios

$FLEX_LOC/amxmlc -swf-version=20 -compiler.source-path=src -static-link-runtime-shared-libraries=true $AIR_PROJECT_ROOT/Main.as -output $BUILD_DIR/flex/Main.swf
$FLEX_LOC/amxmlc -debug=true experiments/blank_air/Blank.as -output $BUILD_DIR/flex/Blank.swf

$AIR_LOC/adt -package \
-target ipa-debug-interpreter-simulator \
-storetype pkcs12 -keystore $KEY_LOC/ttm_app_key.p12 \
-storepass Apangea%123 \
$BUILD_LOC/TTM_mobile_simulator.ipa \
$BIN_DIR/ttm_mobile-app-as3-as.xml \
-C $BUILD_DIR/flex Main.swf Blank.swf \
-C $AIR_PROJECT_ROOT icons \
-platformsdk /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator6.1.sdk

$AIR_LOC/adt -installApp \
-platform ios \
-platformsdk /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator6.1.sdk \
-device ios-simulator \
-package $BUILD_LOC/TTM_mobile_simulator.ipa

$AIR_LOC/adt -launchApp \
-platform ios \
-platformsdk /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator6.1.sdk \
-device ios-simulator \
-appid proto.ttm.mobileplayer
