#!/bin/sh

MODE=$1
DEBUG=0

if [[ "$MODE" == *debug* ]];then
  DEBUG=1
  MODE="$MODE -listen 9999"
fi


AIR_LOC=runtimes/AdobeAIRSDK/bin
FLEX_LOC=runtimes/flex_sdk_4.6/bin
KEY_LOC=keys/ios
BUILD_LOC=builds/ios

$FLEX_LOC/amxmlc -debug=true -swf-version=20 Main.as
$FLEX_LOC/amxmlc -debug=true -swf-version=20 experiments/blank_air/Blank.as

cp experiments/blank_air/Blank.swf ./Blank.swf

$AIR_LOC/adt -package -target $MODE \
-keystore $KEY_LOC/ttm_app_key.p12 -storetype pkcs12 -storepass Apangea%123 \
-provisioning-profile $KEY_LOC/TTM_AIR_ADHOC_Mobile.mobileprovision \
$BUILD_LOC/TTM_Mobile.ipa \
ttm_mobile-app-as3-as.xml \
Main.swf icons Blank.swf

echo "Finished Build ipa"

rm Blank.swf

echo "Removing extra swf resources"
echo "Listing devices"
DEVICE_ID=`$AIR_LOC/../lib/aot/bin/iOSBin/idb -devices | tail -1 | awk '{print $1}'`

echo "DEVICE id $DEVICE_ID"

echo "Uninstalling App on device"
$AIR_LOC/adt -uninstallApp -platform ios -device $DEVICE_ID -appid proto.ttm.mobileplayer

echo "Installing new build"

$AIR_LOC/adt -installApp -platform ios -device $DEVICE_ID -package $BUILD_LOC/TTM_Mobile.ipa

if [[ "$DEBUG" == "1" ]]; then
  echo "Running idb forwarding on 8999"
  echo "run $FLEX_LOC/fdb 8999 and run"

  $AIR_LOC/../lib/aot/bin/iOSBin/idb -forward 8999 9999 $DEVICE_ID
  #$FLEX_LOC/fdb 8999
fi
