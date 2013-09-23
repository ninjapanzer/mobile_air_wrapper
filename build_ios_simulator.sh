#!/bin/sh

AIR_LOC=runtimes/AdobeAIRSDK/bin
KEY_LOC=keys/ios
BUILD_LOC=builds/ios

$AIR_LOC/adt -package \
-target ipa-test-interpreter-simulator \
-storetype pkcs12 -keystore $KEY_LOC/ttm_app_key.p12 \
-storepass Apangea%123 \
$BUILD_LOC/TTM_mobile_simulator.ipa \
ttm_mobile-app-as3-as.xml \
Main.swf icons \
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